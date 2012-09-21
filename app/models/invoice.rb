class Invoice 


 def self.find(id)

 end

 def self.find_by_owner(username)
    db = SQLite3::Database.new( '/home/obi/bin/yeti/invoice.db' )
    db.results_as_hash=true
    query = "select * from invoice where username = '" + username +"'"
    puts query.inspect
    rows = db.execute(query)   
    #puts rows.inspect
    return rows
 end

end
