class SessionsController < ApplicationController
before_filter :start_page_title

 def start_page_title
  @page_title = "Website Uptime Monitoring | SouthMunn.com"
  @page_title = "Sign in - " + @page_title
 end

  def new
    @user = User.new
    render :layout => "login"
  end

 def send_password_reset_code
  if User.email_not_found(params[:session][:email])
    flash[:notice]  =  'Email address not found'
   else
    domain = request.host_with_port
    UserMailer.password_reset_email(params[:session][:email],domain).deliver
    flash[:success] = 'We have sent you an email to reset your password.'
   end
    redirect_to signin_path 
 end

 def forgot_password
 end
 
  def create
   @user = User.new
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
