# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Yeti::Application.initialize!

#admin user name and password is required to use the system
@@username = 'admin' 
@@password = 'yeti' 

#For Twitter notifications
#@@consumer_key = 'Consumer Key'
#@@consumer_secret = 'Consumer secret'
#@@access_token = 'access token'
#@@access_token = 'access secret' 

#For Gmail notifications 
# @@username = 'gmail_username'  #replace with gmail username
# @@password =  'gmail_password' #replace with gmail password

#Add your monitors here
@@monitoring =  { :monitor => 'url',
                   :every => '15m',
                   :test => 'github repo a http test',
                   :url => 'https://github.com/obi-a/Ragios',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  
                  },

		   {:monitor =>'http',
                   :every => '30m',
                   :test => 'Http connection to my blog',
                   :domain => 'obi-akubue.org',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  } ,
                  { :monitor => 'url',
                   :every => '30m',
                   :test => 'My Website Test',
                   :url => 'http://www.whisperservers.com/blog/',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  
                  }

#Add status report settings here
#@@status_report = {:every => '1d',
#			:contact => 'admin@mail.com',
#			:via => 'gmail'}
