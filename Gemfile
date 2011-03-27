source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'capistrano'

gem 'omniauth'

gem 'ruby-debug'

if RUBY_PLATFORM.downcase.include?("w32")
  gem 'mysql'
else
  gem 'mysql2'
end


group :test do
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'mocha'
end

group :development do
  gem 'mongrel'
  gem 'nifty-generators'
  gem 'annotate-models'
end
