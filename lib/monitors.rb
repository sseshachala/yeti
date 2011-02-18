module Whisper

 class Monitors

   attr :monitors

    def self.get_monitors
     return @monitors 
    end

    def self.start  
      monitoring =  { :monitor => 'url',
                   :every => '30s',
                   :test => 'github repo a http test',
                   :url => 'https://github.com/obi-a/Ragios',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  
                  },

		   {:monitor =>'http',
                   :every => '2m',
                   :test => 'Http connection to my blog',
                   :domain => 'obi-akubue.org',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  } ,
                  { :monitor => 'url',
                   :every => '2m',
                   :test => 'My Website Test',
                   :url => 'http://www.whisperservers.com/blog/',
                   :contact => 'obi.akubue@mail.com',
                   :via => 'gmail',  
                   :notify_interval => '6h'
                  
                  }

      @monitors = Ragios::Monitor.start monitoring
    end       
 end

end
