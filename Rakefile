# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'leanback'
require 'sqlite3'

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

  data = { :admins => {"names" => ["obi"], "roles" => ["admin"]},
                   :readers => {"names" => ["obi"],"roles"  => ["admin"]}
                  }
 Couchdb.create 'usage_meter',auth_session
 Couchdb.set_security('usage_meter',data,auth_session)

#now using sqlite
# Couchdb.create 'invoice',auth_session
# Couchdb.set_security('invoice',data,auth_session)

db = SQLite3::Database.new( 'invoice.db' )

 rows = db.execute( "CREATE TABLE invoice (
   id text UNIQUE,
   balance real,
   billing_period text,
   date_due text,
   status text,
   url_monitoring INTEGER,
   username text
  );" )

 Couchdb.create 'payment_history',auth_session
 Couchdb.set_security('payment_history',data,auth_session)

 Couchdb.create 'payment_errors',auth_session
 Couchdb.set_security('payment_errors',data,auth_session)

 Couchdb.create 'lycan_diary',auth_session
 Couchdb.set_security('lycan_diary',data,auth_session)
end

task :setdb => :db_setup
task :setbill => :db_billing
