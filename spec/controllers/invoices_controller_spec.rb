require 'spec_helper'

describe InvoicesController do

  it " should GET the billing history" do
      get :billing_history, :id => 'yeti'
      response.should redirect_to("/signin")  
  end

end
