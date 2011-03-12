module Whisper

 class Monitors

   attr :monitors

    def self.get_monitors
     return @monitors 
    end

    def self.start  
      

      @monitors = Ragios::Monitor.start @@monitoring
    end       
 end

end
