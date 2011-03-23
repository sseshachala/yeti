module Whisper

 class Monitors

   attr :monitors

    def self.get_monitors
     return @monitors 
    end

    def self.start  
      

      @monitors = Ragios::Monitor.start @@monitoring

     if defined?(@@status_report) != nil
        Ragios::Monitor.update_status(@@status_report)
     end
    
    end       
 end

end
