module Whisper

 class Monitor

   attr :monitors

    def self.get_monitors
     return @monitors 
    end

    def self.start  
      

      @monitors = Ragios::Monitor.start @@monitoring
     
     #send status reports if one is defined
     if defined?(@@status_report) != nil
        Ragios::Monitor.update_status(@@status_report)
     end
    
    end       
 end

end
