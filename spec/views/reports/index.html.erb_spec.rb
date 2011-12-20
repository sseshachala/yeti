require 'spec_helper'

describe "reports/index.html.erb" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :every => "Every",
        :email => "Email"
      ),
      stub_model(Report,
        :every => "Every",
        :email => "Email"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Every".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
