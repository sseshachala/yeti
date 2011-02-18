require 'monitors'

class RagiosController < ApplicationController
 
 attr :monitors
 
 def init
    
   Whisper::Monitors.start
 end

 def monitors
      @monitors = Whisper::Monitors.get_monitors
 end

end
