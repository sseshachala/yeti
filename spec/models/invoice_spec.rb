require 'spec_helper'

describe Invoice do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it "should find invoices owned by user" do
   rows =  Invoice.find_by_owner("yeti")
   hash = rows[0]
   hash.include?("id").should == true
   hash.include?("balance").should == true
   hash.include?("billing_period").should == true
   hash.include?("date_due").should == true
   hash.include?("status").should == true 
   hash.include?("url_monitoring").should == true 

   rows =  Invoice.find_by_owner("obi-a")
   rows.should == []
  end

end
