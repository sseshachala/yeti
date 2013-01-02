class SessionsController < ApplicationController

  def new
    render :layout => "login"
  end

 def send_password_reset_code
    domain = request.host_with_port
    UserMailer.password_reset_email(params[:session][:email],domain).deliver
    redirect_to signin_path, :notice => 'We have sent you an email to reset your password.'
 end

 def forgot_password
 end
 
  def create
   user = User.authenticate(params[:session][:username],
                                params[:session][:password])

   if user.nil?
    
     flash.now[:errors] = "Invalid username/password combination."
     
     render 'new',:layout => "login"
   else
     sign_in user
     #redirect_to show_path("users",  user["username"])#User.new(user)
     redirect_back_or show_path("dashboard",  user["username"])
   end
  end

  def destroy
   sign_out
   redirect_to "/"
  end                             
end
