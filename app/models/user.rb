class User 

include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :username, :presence => true,
                     :length => {:maximum => 50}

validates :email, :presence => true,
                  :format => {:with => email_regex}

validates :password, :presence => true,
                  :confirmation => true,
                  :length => {:within => 6..40}


attr_accessor :attributes, :username, :email, :password, :password_confirmation

 

 def initialize(attributes = {})
    @attributes = attributes
    @username = @attributes["username"]
    @email = @attributes["email"]
  end


 
  def read_attribute_for_validation(key)
    @attributes[key]
  end

def save
  if self.valid?
   hash = Couchdb.login(username = 'obi',password ='trusted') 
   auth_session =  hash["AuthSession"]
   user = { :username => @attributes["username"], :password => "trusted", :roles => []}
   Couchdb.add_user(user,auth_session)

   data = {:username=> @attributes["username"],:email => @attributes["email"] }
   doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + @attributes["username"], :data => data}   
   Couchdb.update_doc doc,auth_session
   true
  else 
   
   false
  end
end

def destroy
  hash = Couchdb.login(username = 'obi',password ='trusted') 
  auth_session =  hash["AuthSession"]
  doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + @attributes["username"]}
  Couchdb.delete_doc doc,auth_session
end

def update_attributes(user_hash)
  @attributes = user_hash
 if self.valid?
  hash = Couchdb.login(username = 'obi',password ='trusted') 
  auth_session =  hash["AuthSession"]
  data = user_hash
  doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + user_hash["username"], :data =>  data}   
  Couchdb.update_doc doc,auth_session
  true
 else
  false
 end
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

def self.find_object(id)

   user_hash = find(id)
   @user = User.new(user_hash)

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