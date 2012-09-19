require 'spec_helper'

describe "invoices/index.html.erb" do
  before(:each) do
    assign(:invoices, [
      stub_model(Invoice,
        :username => "Username",
        :url_monitoring => 1,
        :status => "Status",
        :date_due => "Date Due",
        :billing_period => "Billing Period",
        :balance => "Balance",
        :id => "Id"
      ),
      stub_model(Invoice,
        :username => "Username",
        :url_monitoring => 1,
        :status => "Status",
        :date_due => "Date Due",
        :billing_period => "Billing Period",
        :balance => "Balance",
        :id => "Id"
      )
    ])
  end

  it "renders a list of invoices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Date Due".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Billing Period".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Balance".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
  end
end
