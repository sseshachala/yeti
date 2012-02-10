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


task :db_billing do
 hash = Couchdb.login(username = 'obi',password ='trusted')
 auth_session =  hash["AuthSession"]

 Couchdb.create 'usage_meter',auth_session
 Couchdb.create 'invoice',auth_session
 Couchdb.create 'payment_history',auth_session
 Couchdb.create 'payment_errors',auth_session
end

task :setdb => :db_setup
task :setbill => :db_billing
