class InvoicesController < ApplicationController
 before_filter :authenticate
 before_filter :must_have_payment_method

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
 
 def must_have_payment_method
    redirect_to (show_path("payment_method",  "")) unless current_user.attributes["payment_info_on_file"]
 end

end
