require 'spec_helper'

describe Rmonitor do
  #pending "add some examples to (or delete) #{__FILE__}"

   it { Rmonitor.should include(ActiveModel::Validations) }

   it "should create a monitor" do
      hash = {"username" =>"monitor_test_user", "email" => "test@yeti.com","password" => "trusted", "password_confirmation" => "trusted"}
      current_user = User.new(hash)

      hash = {"every"=>"5m", "test"=>"sample test", "url"=>"http://sample-test.com", "notify_interval"=>"6h"}
      
       @rmonitor = Rmonitor.new(hash)
       @rmonitor.create_monitor(current_user).should == true
   end

   it "should find monitor by owner" do 
     attributes = Rmonitor.find_by_owner("monitor_test_user")     
     hash =  attributes[0]
     hash["monitor"].should == "metered_url_monitor"
     hash["tag"].should == "monitor_test_user"
     hash["url"].should == "http://sample-test.com"
     hash["contact"].should == "test@yeti.com"
   end

   it "should find a monitor" do 
      attributes = Rmonitor.find_by_owner("monitor_test_user")     
     hash =  attributes[0]
     id = hash["_id"]
     @rmonitor = Rmonitor.find(id)
     @rmonitor["_id"].should == id
     @rmonitor["monitor"].should == "metered_url_monitor"
     @rmonitor["tag"].should == "monitor_test_user"
     @rmonitor["url"].should == "http://sample-test.com"
     @rmonitor["contact"].should == "test@yeti.com"

      @rmonitor = Rmonitor.find_object(id)
      @rmonitor.contact.should == "test@yeti.com"
      @rmonitor.test.should == "sample test"
      @rmonitor.attributes["_id"].should == id
       @rmonitor.attributes["tag"].should == "monitor_test_user"
      
   end

   it "should update a monitor" do

   end

   it "should delete a monitor" do
  
     attributes = Rmonitor.find_by_owner("monitor_test_user")     
     hash =  attributes[0]
     id = hash["_id"]
     @rmonitor = Rmonitor.find_object(id)

     hash = @rmonitor.destroy 
     hash.include?("ok").should == true
     hash.include?("true").should == true
   end
end
