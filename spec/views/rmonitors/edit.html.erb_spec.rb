require 'spec_helper'

describe "rmonitors/edit.html.erb" do
  before(:each) do
    @rmonitor = assign(:rmonitor, stub_model(Rmonitor,
      :every => "MyString",
      :test => "MyString",
      :contact => "MyString",
      :url => "MyString",
      :notify_interval => "MyString"
    ))
  end

  it "renders the edit rmonitor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rmonitors_path(@rmonitor), :method => "post" do
      assert_select "input#rmonitor_every", :name => "rmonitor[every]"
      assert_select "input#rmonitor_test", :name => "rmonitor[test]"
      assert_select "input#rmonitor_contact", :name => "rmonitor[contact]"
      assert_select "input#rmonitor_url", :name => "rmonitor[url]"
      assert_select "input#rmonitor_notify_interval", :name => "rmonitor[notify_interval]"
    end
  end
end
