require 'spec_helper'

describe "rmonitors/show.html.erb" do
  before(:each) do
    @rmonitor = assign(:rmonitor, stub_model(Rmonitor,
      :every => "Every",
      :test => "Test",
      :contact => "Contact",
      :url => "Url",
      :notify_interval => "Notify Interval"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Every/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Test/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contact/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Notify Interval/)
  end
end
