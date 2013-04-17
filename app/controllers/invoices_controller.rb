class InvoicesController < ApplicationController
 before_filter :authenticate
 before_filter :start_breadcrumb
 before_filter :start_page_title

def start_page_title
 @page_title = "Website Uptime Monitoring | SouthMunn.com"
end

def start_breadcrumb
    invoice_url = "/billing_history/"+ current_user.attributes["username"]
    @breadcrumb = {"billing history" => invoice_url}
    @navigation = "profile"
end


  def billing_history
   @page_title = "Billing History - " + @page_title
   if (params[:id] == current_user.attributes["username"]) || current_user.admin?
      @invoices = Invoice.find_by_owner(params[:id])
   else
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
   end
  end

 
 private 

  def authenticate
   deny_access unless signed_in?
 end

end
