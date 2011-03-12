# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Yeti::Application.initialize!

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
