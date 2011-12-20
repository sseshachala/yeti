require 'spec_helper'

describe "reports/show.html.erb" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :every => "Every",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Every/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
  end
end
