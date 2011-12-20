require 'spec_helper'

describe "reports/edit.html.erb" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :every => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path(@report), :method => "post" do
      assert_select "input#report_every", :name => "report[every]"
      assert_select "input#report_email", :name => "report[email]"
    end
  end
end
