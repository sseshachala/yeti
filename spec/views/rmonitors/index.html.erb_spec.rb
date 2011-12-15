require 'spec_helper'

describe "rmonitors/index.html.erb" do
  before(:each) do
    assign(:rmonitors, [
      stub_model(Rmonitor,
        :every => "Every",
        :test => "Test",
        :contact => "Contact",
        :url => "Url",
        :notify_interval => "Notify Interval"
      ),
      stub_model(Rmonitor,
        :every => "Every",
        :test => "Test",
        :contact => "Contact",
        :url => "Url",
        :notify_interval => "Notify Interval"
      )
    ])
  end

  it "renders a list of rmonitors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Every".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Test".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notify Interval".to_s, :count => 2
  end
end
