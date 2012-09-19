require 'spec_helper'

describe "invoices/show.html.erb" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :username => "Username",
      :url_monitoring => 1,
      :status => "Status",
      :date_due => "Date Due",
      :billing_period => "Billing Period",
      :balance => "Balance",
      :id => "Id"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Date Due/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Billing Period/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Balance/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id/)
  end
end
