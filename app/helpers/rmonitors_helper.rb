module RmonitorsHelper

 def every(e)
   if e.include? "m"
      e["m"] = " minutes"
   end
   return e
 end

end
