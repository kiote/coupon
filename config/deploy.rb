$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Для работы rvm
require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano' # Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика.

set :application, "coupon"
set :repository,  "git@github.com:kiote/coupon.git"

set :scm, :git

set :deploy_to, "/srv/www/roradvice"

server "62.75.191.219", :web
set :user, "apps"
set :use_sudo, false

set :branch, "master"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :rails_env, "production"

set :rvm_type, :user # Указывает на то, что мы будем использовать rvm, установленный у пользователя, от которого происходит деплой, а не системный rvm.

role :web, "62.75.191.219"                          # Your HTTP server, Apache/etc
role :app, "62.75.191.219"
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "62.75.191.219", :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  # end

  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
 end
