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

  it "should delete a user" do
   @user = User.find_object("test_user")
   hash = @user.destroy
   hash.include?("ok").should == true
   hash.include?("rev").should == true
   hash["id"].should == 'org.couchdb.user:test_user'
  end

end
