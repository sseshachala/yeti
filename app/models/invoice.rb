class Invoice 


 def self.find(id)

 end

 def self.find_by_owner(username)
    #TODO: re-build later using couchDB
    #db = SQLite3::Database.new(@@invoice_db_path)
    #db.results_as_hash=true
    #query = "select * from invoice where username = '" + username +"'"
    #rows = db.execute(query)   
    return []
 end

end
