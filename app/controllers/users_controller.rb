class UsersController < ApplicationController
before_filter :authenticate, :only => [:index,:show,:edit,:update,:confirm]
before_filter :correct_user, :only => [:show,:edit,:update]
before_filter :admin_user, :only => [:index,:destroy]

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
   session[:password_verifying_username] = params[:id]
   @user = User.find_object(params[:id]) 
   if !(@user.is_valid_password_reset_code?(params[:code]))
      redirect_to(signin_path, :notice => 'Something went wrong, cannot reset password.')
   end
end

 def restore_password
     password_verifying_username = session[:password_verifying_username]
     session[:password_verifying_username] = nil
     puts "the id is " + password_verifying_username
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
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_object(params[:id])
  end

  def send_confirmation_email
   domain = request.host_with_port
   UserMailer.confirmation_email(current_user,domain).deliver
   redirect_to(show_path("dashboard", current_user.attributes["username"]),:notice => 'We have re-sent the confirmation email, Remember to check your inbox if you did not receive it')
  end


  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        #domain = request.host
        domain = request.host_with_port
        UserMailer.confirmation_email(@user,domain).deliver
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
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
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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
