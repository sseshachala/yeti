class UsersController < ApplicationController
before_filter :authenticate, :only => [:index,:show,:edit,:update,:confirm]
before_filter :correct_user, :only => [:show,:edit,:update]
before_filter :admin_user, :only => [:index,:destroy]
before_filter :start_breadcrumb, :except => [:new,:create] 
before_filter :start_page_title

def start_page_title
 @page_title = "Website Uptime Monitoring | SouthMunn.com"
end

def start_breadcrumb
    profile_url = "/users/"+ current_user.attributes["username"]
    @breadcrumb = {"profile" => profile_url}
    @navigation = "profile"
end

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


 def add_payment_method
    @page_title = "Add Payment Method - " + @page_title
    payment_method_url = "/payment_method/"
    @breadcrumb = @breadcrumb.merge("Payment Method" => payment_method_url)
 end

 def authorized   
  if current_user.authorized_payment?(params)
     flash[:success] = "You have successfully authorized payments"
  else
     flash[:error] = "Something went wrong with your payment authorization"
  end
    redirect_to(show_path("dashboard", current_user.attributes["username"]))
 end

 def authorize_payments     
   redirect_to User.amazon_cbui_url(current_user.attributes["username"])
 end

 def verify_password_reset_code
   @user_hash = User.find(params[:id])
   session[:password_verifying_username] = params[:id]
   @user = User.find_object(params[:id]) 
   if !(@user.is_valid_password_reset_code?(params[:code]))
      redirect_to(signin_path, :notice => 'Something went wrong, cannot reset password.')
   end
end

 def restore_password
     @user_hash = User.find(params[:id])
     password_verifying_username = session[:password_verifying_username]
     session[:password_verifying_username] = nil
     @user = User.find_object(password_verifying_username)
    respond_to do |format|
      if @user.reset_password(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "verify_password_reset_code" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
 end

  # GET /users/1
  # GET /users/1.xml
  def show
     @page_title = "All Users - " + @page_title
    @user_hash = User.find(params[:id])
    @user = User.find_object(params[:id])
    @page_title = "Profile - " + @page_title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_hash }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @page_title = "Sign Up - " + @page_title
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_object(params[:id])
  end

  def edit_email
    @user = User.find_object(params[:id])
  end

  def edit_password
    @user = User.find_object(params[:id])
  end

  def send_confirmation_email
   domain = request.host_with_port
   UserMailer.confirmation_email(current_user,domain).deliver
   redirect_to(show_path("dashboard", current_user.attributes["username"]),:notice => 'We have re-sent the confirmation email, Remember to check your spam if you did not receive it')
  end


  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @page_title = "Sign Up - " + @page_title
    respond_to do |format|
      if @user.save
        #domain = request.host
        domain = request.host_with_port
        UserMailer.confirmation_email(@user,domain).deliver
         flash[:success] = "Congratulations. You have successfully created your account. Please login with your username & password" 
        
        format.html { redirect_to("/signin",:notice => 'Congratulations. You have successfully created your account. Please login with your username & password' ) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

 def confirm
 if(current_user.confirmed_email?(params[:id]))
  flash[:success] = "Your email address was confirmed successfully"
 else
  flash[:success] = "Sorry: Your email address could not be confirmed"
 end
    respond_to do |format|
      format.html { redirect_to(show_path("dashboard",  current_user.attributes["username"])) }
      format.xml  { head :ok }
    end
 end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_object(params[:id])
     user_hash = params[:user]
    respond_to do |format|
       #TODO avoid mass assignment 
      if @user.update_attributes(params[:user],current_user)
        domain = request.host_with_port
        UserMailer.confirmation_email(@user,domain).deliver unless (user_hash["email"] == current_user.attributes["email"])
        format.html { redirect_to(@user, :notice => 'We have sent you a confirmation') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


 

  def update_email
    update_email_url = "/update_email/"+ current_user.attributes["username"]
    @breadcrumb = @breadcrumb.merge("change email" => update_email_url)
    @page_title = "Change Email - " + @page_title
    @user = User.find_object(params[:id])
     user_hash = params[:user]
    respond_to do |format|
       #TODO avoid mass assignment 
      if @user.update_email_attributes(params[:user],current_user)
        domain = request.host_with_port
        UserMailer.confirmation_email(@user,domain).deliver unless (user_hash["email"] == current_user.attributes["email"])
        format.html { redirect_to(show_path("users",  current_user.attributes["username"]), :notice => 'Your account has been updated. We have sent you a confirmation to confirm the new email address. Please check your inbox.')  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_email" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

 def update_password

     update_email_url = "/update_password/"+ current_user.attributes["username"]
    @breadcrumb = @breadcrumb.merge("change password" => update_email_url)
    @page_title = "Change Password - " + @page_title

    @user = User.find_object(params[:id])
     user_hash = params[:user]
    respond_to do |format|
       #TODO avoid mass assignment 
      if @user.update_password_attributes(params[:user],current_user)
        format.html { redirect_to(@user, :notice => 'User Password was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_password" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_object(params[:id])
    @user.destroy
    flash[:success] = "User destroyed."
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  private
   
   def authenticate
     deny_access unless signed_in?
   end

   def correct_user
      @user = User.find_object(params[:id])
      redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless current_user?(@user)
   end

   def admin_user
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless current_user.admin?
   end
end
