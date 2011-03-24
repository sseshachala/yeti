require 'monitors'

class RagiosController < ApplicationController
 
 attr :monitors
 
 def init
    Whisper::Monitors.start
    redirect_to :action => 'monitors'
 end

 def monitors
    @monitors = Whisper::Monitors.get_monitors
    #if the monitors have not been initialized, return to init to start the monitoring system
    if @monitors == nil
     redirect_to :action => 'init'  
    end
  
 end

 def test_monitor
     @id = params[:id].to_i
     monitors = Whisper::Monitors.get_monitors
     @monitor = monitors[@id]
     @monitor.test_command

     begin 
          @monitor.time_of_last_test = Time.now 
 	  if @monitor.test_command
             @monitor.num_tests_passed = @monitor.num_tests_passed + 1
             @status = "PASSED"
             @monitor.has_failed = nil #FALSE 
  	  else
           @monitor.num_tests_failed = @monitor.num_tests_failed + 1
           @monitor.failed
           @status = "FAILED"
           @monitor.has_failed = TRUE
  	  end
   	  
	rescue Exception
           @status = "FAILED"
           @monitor.has_failed = TRUE
           @monitor.error_handler
           raise
        end
       @monitor.total_num_tests = @monitor.total_num_tests + 1   

 end 

end
