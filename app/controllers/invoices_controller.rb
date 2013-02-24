class InvoicesController < ApplicationController
 before_filter :authenticate
 before_filter :start_breadcrumb

def start_breadcrumb
    invoice_url = "/billing_history/"+ current_user.attributes["username"]
    @breadcrumb = {"billing history" => invoice_url}

end


  def billing_history
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
