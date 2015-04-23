require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :rails_env, 'production'
set :domain, '46.101.28.50'
set :deploy_to, '/home/deployer/timetracker'
set :repository, 'git@github.com:vano468/timetracker.git'
set :branch, 'master'
set :user, 'deployer'
set :forward_agent, true
set :term_mode, nil
set :port, '22'

set :shared_paths, %w{
  config/application.yml
  config/database.yml
  config/secrets.yml
  log
}

task :environment do
  invoke :'rvm:use[ruby-2.2.1@default]'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/application.yml'."]
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'passenger:restart'
    end
  end
end

desc 'Restarts the nginx server.'
task :restart do
  invoke :'passenger:restart'
end

namespace :passenger do
  task :restart do
    queue "mkdir -p #{deploy_to}/current/tmp; touch #{deploy_to}/current/tmp/restart.txt"
  end
end