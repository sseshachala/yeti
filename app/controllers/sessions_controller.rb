class SessionsController < ApplicationController

  def new
  end

  def create
   user = User.authenticate(params[:session][:username],
                                params[:session][:password])

   if user.nil?
     flash.now[:errors] = "Invalid email/password combination."
     render 'new'
   else
     sign_in user
     #redirect_to show_path("users",  user["username"])#User.new(user)
     redirect_back_or show_path("dashboard",  user["username"])
   end
  end

  def destroy
   sign_out
   redirect_to signin_path
  end                             
end
