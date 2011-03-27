set :application, "sc2events.com"
set :deploy_to, "/srv/www/sc2events"
set :user, "sc2events"
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:honzasterba/sc2events.git"
set :keep_releases, 10
set :deploy_via, :remote_cache

role :web, "going.cz"                          # Your HTTP server, Apache/etc
role :app, "going.cz"                          # This may be the same as your `Web` server
role :db,  "going.cz", :primary => true        # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :config do
  task :create_symlinks do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

after :deploy, 'config:create_symlinks'

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(release_path, 'vendor/bundle')
    run "mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}"
  end

  task :install, :roles => :app do
    run "cd #{release_path} && bundle install --deployment"

    on_rollback do
      if previous_release
        run "cd #{previous_release} && bundle install --deployment"
      else
        logger.important "no previous release to rollback to, rollback of bundler:install skipped"
      end
    end
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    bundler.install
  end

end

after "deploy:rollback:revision", "bundler:install"
after "deploy:update_code", "bundler:bundle_new_release"
