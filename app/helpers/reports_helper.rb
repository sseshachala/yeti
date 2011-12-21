module ReportsHelper

 def has_report?(tag)
  if Report.find_by_owner(tag) == {}
     false
  else
     true
  end
 end

 def report_id(tag)
   hash = Report.find_by_owner(tag)
   id = hash["_id"]
 end

end
