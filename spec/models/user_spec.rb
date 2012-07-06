require 'spec_helper'


describe User do
 # pending "add some examples to (or delete) #{__FILE__}"


 it { User.should include(ActiveModel::Validations) }

 it "should create a user" do
   
  hash = {"username" =>"test_user", "email" => "test@yeti.com","password" => "trusted", "password_confirmation" => "trusted"}
   @user = User.new(hash)
   hash = @user.create_user
   hash.include?("ok").should == true
   hash.include?("rev").should == true
   hash["id"].should == 'org.couchdb.user:test_user'
  end

  it "should authenticate user" do
   hash = User.authenticate("test_user","trusted")
   hash["_id"].should == 'org.couchdb.user:test_user'  

   User.authenticate("test_user","wrong_password").should == nil
   User.authenticate("wrong_user","wrong_password").should == nil
     
  end

  it "should find user" do
  
   hash = User.find("test_user")
   hash["name"].should == 'test_user'
   hash["email"].should == 'test@yeti.com'
   hash["_id"].should == 'org.couchdb.user:test_user'

   @user = User.find_object("test_user")
   @user.username.should == 'test_user'
   @user.email.should == 'test@yeti.com'
   @user.attributes["name"].should == 'test_user'
   @user.attributes["email"].should == 'test@yeti.com'
  end

  it "should update user's email" do
       
    current_user = User.find_object("test_user")
    user_hash = {"email"=>"new.email@yeti.com", "password"=>"", "password_confirmation"=>""}
    @user = current_user
    hash = @user.update_email(user_hash,current_user)
    hash.include?("ok").should == true
    hash.include?("rev").should == true
    hash["id"].should == 'org.couchdb.user:test_user'


    #if email has not changed
    current_user = User.find_object("test_user")
    user_hash = {"email"=>"new.email@yeti.com", "password"=>"", "password_confirmation"=>""}
    @user = current_user
    @user.update_email(user_hash,current_user).should == nil 

   end

  it "should update password" do
    current_user = User.find_object("test_user")
    user_hash = {"email"=>"new.email@yeti.com", "password"=>"abc123", "password_confirmation"=>"abc123"}
    @user = current_user
    hash = @user.update_password(user_hash,current_user)
    hash.include?("ok").should == true
    hash.include?("rev").should == true
    hash["id"].should == 'org.couchdb.user:test_user'
  end

 it "should get all users" do
   hash = User.all
   hash[0].include?("username").should == true
   hash[0].include?("email").should == true
 end
 
 it "should check if user is an admin" do
   #assumes that the admin user yeti has been created
   #otherwise disable this test, it would fail unless an admin user yeti exists
   #for security reasons admins can only be created directly on couchdb.
   @user = User.find_object("yeti")
   @user.admin?.should == true  

   @user = User.find_object("test_user")
   @user.admin?.should == false     
 end


 it "should authenticate with salt" do
   hash = User.find("test_user")
   cookie_salt = hash["salt"]
   @user = User.authenticate_with_salt("test_user", cookie_salt)
   @user.username.should == 'test_user'
   @user.attributes["name"].should == 'test_user'
   @user.attributes["_id"].should == 'org.couchdb.user:test_user'

   User.authenticate_with_salt("test_user", "wrong_salt").should == nil
   User.authenticate_with_salt(nil, nil).should == nil
 end

  it "should find user with forgotten emails" do
    User.found_user_with_forgotten_email?("new.email@yeti.com").should == true
    User.found_user_with_forgotten_email?("unknown.email@yeti.com").should == false
  end

  it "should create a password reset code" do
    password_reset_code = User.password_reset_code('new.email@yeti.com')
    hash = User.find("test_user")
    password_reset_code.should == hash["name"] + "/" + hash["password_reset_code"]
    User.password_reset_code('wrong@email.com').should == nil
  end

   it "should check if password reset code is valid" do
    #true.should == false
    #restore password controller action call to update_attributes needs to be fixed 
   end

  it "should delete a user" do
   @user = User.find_object("test_user")
   hash = @user.destroy
   hash.include?("ok").should == true
   hash.include?("rev").should == true
   hash["id"].should == 'org.couchdb.user:test_user'
  end

end
