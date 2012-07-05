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


    #do if email was not changed
    current_user = User.find_object("test_user")
    user_hash = {"email"=>"new.email@yeti.com", "password"=>"", "password_confirmation"=>""}
    @user = current_user
    @user.update_email(user_hash,current_user).should == nil 

   end

  it "should update password" do

  end

  it "should delete a user" do
   @user = User.find_object("test_user")
   hash = @user.destroy
   hash.include?("ok").should == true
   hash.include?("rev").should == true
   hash["id"].should == 'org.couchdb.user:test_user'
  end

end
