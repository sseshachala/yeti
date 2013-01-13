module RmonitorsHelper

 def every(e)
   if e.include? "m"
      e["m"] = " minute(s)"
   elsif e.include? "h" 
      e["h"] = " hour(s)" 
   elsif e.include? "d" 
       e["d"] = " day(s)"
   end
   return e
 end

def time(monitor)
  m = monitor.every
  #delete the last character which is the hour, minute or seconds symbol
  m = m.delete(m[-1])
end

def time_unit(monitor)
   m =  monitor.every
   m =  m[-1]
   
   if m == "m" 
      return {"minutes" =>"m","hours"=>"h","days" => "d"}
   elsif m == "h"
      return {"hours"=>"h","minutes" =>"m","days" => "d"}
   elsif m == "d"
      return {"days" => "d","hours"=>"h","minutes" =>"m"}

  else
      raise "Invalid time unit"
   end
end

def make_monitor(params)
  monitor = params["rmonitor"]
  
   if params["create"].has_value?("m")
       time = "m"
   elsif params["create"].has_value?("h")
       time = "h"
   elsif params["create"].has_value?("d")
       time = "d"
   else
       raise "invaid time unit input for monitor"
   end
    
  monitor["every"] = monitor["every"] + time

  return monitor
 end

end
