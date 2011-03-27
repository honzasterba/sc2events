require "bundler/capistrano"

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
