class User 

include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion

attr_accessor :attributes
attr_accessor :username
attr_accessor :email
  
 def initialize(attributes = {})
    @attributes = attributes
  end
 
  def read_attribute_for_validation(key)
    @attributes[key]
  end


 def persisted?
  false
 end

def self.find(id)
  hash = Couchdb.login(username = 'obi',password ='trusted') 
  auth_session =  hash["AuthSession"]
  attributes =   Couchdb.find_by({:database => '_users', :username => id} , auth_session)  
  user_hash = attributes[0]
end

 def self.all

   hash = Couchdb.login(username = 'obi',password ='trusted') 
   auth_session =  hash["AuthSession"]

   view = { :database => "_users", 
          :design_doc => 'for_rails', 
            :view => 'get_all'}
 
  @users = Couchdb.find(view,auth_session)
  
 end


end
