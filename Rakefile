# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'leanback'

Yeti::Application.load_tasks

task :db_setup do
 
 hash = Couchdb.login(username = 'obi',password ='trusted') 
 auth_session =  hash["AuthSession"]

 doc = { :database => '_users', 
           :design_doc => 'for_rails', 
            :json_doc => 'for_rails.json' }
 
 Couchdb.create_design doc,auth_session
end

task :setdb => :db_setup
