require 'spec_helper'

describe "reports/new.html.erb" do
  before(:each) do
    assign(:report, stub_model(Report,
      :every => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path, :method => "post" do
      assert_select "input#report_every", :name => "report[every]"
      assert_select "input#report_email", :name => "report[email]"
    end
  end
end
