class User 

include ActiveModel::Validations
include ActiveModel::Serialization
extend ActiveModel::Naming 
include ActiveModel::Conversion

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :username, :presence => true,
                     :length => {:maximum => 50},
                     :on => :registration
                     

                  

validates :email, :presence => true,
                  :format => {:with => email_regex},
                  :on => :registration

validates :email, :presence => true,
                  :format => {:with => email_regex},
                  :on => :update_profile
                  

validates :password, :presence => true,
                  :confirmation => true,
                  :length => {:within => 6..40},
                  :on => :registration

validates :password, :length => {:within => 6..40},
                  :allow_blank => true,
                  :on => :update_profile

validates :password, :length => {:within => 6..40},
                  :presence => true,
                  :on => :reset_password

 

attr_accessor :attributes, :username, :email, :password, :password_confirmation

 

 def initialize(attributes = {})
    @attributes = attributes
    @username = @attributes["username"]
    @email = @attributes["email"]
    @password = @attributes["password"]
    @password_confirmation = @attributes["password_confirmation"]
  end


def self.auth_session
   hash = Couchdb.login(username = @@username,password =@@password) 
   auth_session =  hash["AuthSession"]
end

def self.authenticate(username, submitted_password)
   begin

     hash = Couchdb.login(username, submitted_password) 
     
     doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + username }
     Couchdb.view doc,User.auth_session
   rescue CouchdbException => e
      if e.to_s == "CouchDB: Error - unauthorized. Reason - Name or password is incorrect."
        return nil
      else 
        raise
      end
   end
end

def self.authenticate_with_salt(username, cookie_salt)
   begin
     if username == nil
       return nil
     end
     doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + username }
     hash = Couchdb.view doc,User.auth_session
     if hash["salt"] == cookie_salt
      User.new(hash) 
     else
      nil
     end
   rescue CouchdbException => e
     return nil
   end
end
 
  def read_attribute_for_validation(key)
    @attributes[key]
  end


def create_user
  user = { :username => @attributes["username"], :password => @attributes["password"], :roles => []}
   Couchdb.add_user(user,User.auth_session)

   data = {:username=> @attributes["username"],:email => @attributes["email"], :confirmed_email => false, :confirmation_code => UUIDTools::UUID.random_create.to_s }
   doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + @attributes["username"], :data => data}   
   Couchdb.update_doc doc,User.auth_session
end

def save
  if self.valid? :registration
   create_user
   true
  else 
   false
  end
end


def self.found_user_with_forgotten_email?(email)

 doc = Couchdb.find_by({:database => '_users', :email => email} , User.auth_session)
 
 if(doc == [])
   false
 else
   true
 end
end

def is_valid_password_reset_code?(code)
   user_hash = User.find(@username)
   if(user_hash["password_reset_code"] == code)
     data = {:password_reset_code => nil}
     doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + @username, :data => data}   
     Couchdb.update_doc doc,User.auth_session
     true
   else
    false
   end
end

def self.password_reset_code(email) 
 begin
  user_hash = Couchdb.find_by({:database => '_users', :email => email} , User.auth_session)
  user = user_hash[0]
  reset_code = UUIDTools::UUID.random_create.to_s
  data = {:password_reset_code => reset_code }
  doc = { :database => '_users', :doc_id => user["_id"], :data => data}   
  Couchdb.update_doc doc, User.auth_session
  user["username"] + "/" + reset_code 
 rescue
  return nil
 end 
end

def confirmation_code
  doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + @username }
  hash = Couchdb.view doc,User.auth_session
  hash["confirmation_code"]
end


def confirmed_email?(current_code)
  doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + @username }
  hash = Couchdb.view doc,User.auth_session
  if current_code == hash["confirmation_code"]
      data = {:confirmation_code => nil,:confirmed_email => true}
      doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + @username, :data => data}   
      Couchdb.update_doc doc,User.auth_session
      true
  else
     false
  end
end

def destroy
  doc = {:database => '_users', :doc_id => 'org.couchdb.user:' + @attributes["username"]}
  Couchdb.delete_doc doc,User.auth_session
end


def update_email(user_hash,current_user)
   if user_hash["email"] != current_user.attributes["email"] 
     #if email address was changed 
     email_confirmation = {:confirmed_email => false, :confirmation_code => UUIDTools::UUID.random_create.to_s } 
     user_hash = user_hash.merge(email_confirmation)
     @attributes = @attributes.merge(email_confirmation)
     @email = user_hash["email"]

     data = user_hash
     doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + current_user.attributes["username"], :data =>  data}   
     Couchdb.update_doc doc, User.auth_session
  end
end

def update_password(user_hash,current_user)
  Couchdb.change_password(current_user.attributes["username"], user_hash["password"], User.auth_session)  
end

def reset_password(user_hash)

   if (user_hash["password"].length < 3) 
     #do it the rails way later
     errors[:password] << "Password is too short (minimum is 6 characters)"
     return false
  end

   if (user_hash["password"].length > 48)
     #do it the rails way later
     errors[:password] << "Password is too long (maximum is 48 characters)"
     return false
  end

   if ( user_hash["password"] != user_hash["password_confirmation"])
       #password confirmation doesn't match
       errors[:password] << "doesn't match confirmation"
       return false
   end
  Couchdb.change_password(@username, user_hash["password"], User.auth_session)
  true
end

def update_attributes(user_hash,current_user)
 @attributes = user_hash
  
 if self.valid? :update_profile
  update_email(user_hash,current_user)
  
  if (user_hash["password"] != "")
     
     #password has changed (password is not blank)
     if ( user_hash["password"] != user_hash["password_confirmation"])
       #password confirmation doesn't match
       errors[:password] << "doesn't match confirmation"
       return false
     end
  
     update_password(user_hash,current_user)
  end
  true
 else
  false
 end
end

 def persisted?
  false
 end

 def self.amazon_cbui_url(username)
  require 'fpscbui'
  Amazon::FPS::Fpscbui.url(username)  
 end

 def authorized_payment?(params)
 #TODO: add tests for this via integration testing
 if((params[:status] == 'SC') || (params[:status] == 'SA') || (params[:status] == 'SB')) && (params[:callerReference] == @attributes["username"])

   data = { :token_id => params[:tokenID], 
              :payment_info_on_file => true }

   doc = { :database => '_users', :doc_id => 'org.couchdb.user:' + @attributes["username"], :data => data}   
   Couchdb.update_doc doc,User.auth_session
   true
  else
   false
  end
 end

 def admin?
  hash = User.find(@attributes["username"])
  if hash["admin"] == "true"
    true
  else
    false
  end  
end


def self.find(id)

  attributes =   Couchdb.find_by({:database => '_users', :username => id} , User.auth_session)  
  user_hash = attributes[0]
end

def self.find_object(id)

   user_hash = find(id)
   @user = User.new(user_hash)

end

 def self.all

   view = { :database => "_users", 
          :design_doc => 'for_rails', 
            :view => 'get_all'}
 
  @users = Couchdb.find(view,User.auth_session)
  
 end


end
