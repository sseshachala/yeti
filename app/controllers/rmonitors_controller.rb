class RmonitorsController < ApplicationController
before_filter :authenticate
before_filter :must_have_payment_method, :only => [:new,:show,:create,:edit,:update, :destroy, :restart, :pause]
before_filter :correct_user, :only => [:show,:edit,:update, :destroy, :restart, :pause]
before_filter :admin_user, :only => [:index]
before_filter :confirmed_email, :only => [:new,:create, :edit, :update]
before_filter :start_breadcrumb 




def start_breadcrumb
    @breadcrumb = {}
    @navigation = "dashboard"
end
  # GET /rmonitors
  # GET /rmonitors.xml
  def index
    @rmonitors = Rmonitor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rmonitors }
    end
  end

  # GET /dashboard/:user
  def dashboard
    @rmonitor = Rmonitor.new #used for adding new monitors from same page
    
   if (params[:id] == current_user.attributes["username"]) || current_user.admin?
    begin 
     @rmonitors = Rmonitor.find_by_owner(params[:id])
    rescue
       #params[:id] will be nil for an admin user so simply redirect to dashboard
       redirect_to(show_path("dashboard",  current_user.attributes["username"]))
    end
   else
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
   end
  end

  # GET /rmonitors/1
  # GET /rmonitors/1.xml
  def show

    show_url = "/rmonitors/" + params[:id]
    @breadcrumb = @breadcrumb.merge("Monitor" => show_url)

    @rmonitor_hash = Rmonitor.find(params[:id])
    @rmonitor = Rmonitor.find_object(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rmonitor }
    end
  end

  # GET /rmonitors/new
  # GET /rmonitors/new.xml
  def new

    new_url = "/rmonitors/new"
    @breadcrumb = @breadcrumb.merge("Add Website" => new_url)

    @rmonitor = Rmonitor.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rmonitor }
    end
  end

  # GET /rmonitors/1/edit
  def edit
    edit_url = "/rmonitors/"+ current_user.attributes["username"] +"/edit"
    @breadcrumb = @breadcrumb.merge("Edit Monitor" => edit_url)

    @rmonitor = Rmonitor.find_object(params[:id])
  end

  # POST /rmonitors
  # POST /rmonitors.xml
  def create
    #@rmonitor = Rmonitor.new(make_monitor(params))
    @rmonitor = Rmonitor.new(params[:rmonitor])

    respond_to do |format|
      if @rmonitor.save(current_user, params)
         flash[:success] = "Website was successfully added."
        format.html { redirect_to(@rmonitor, :notice => 'Rmonitor was successfully created.') }
        format.xml  { render :xml => @rmonitor, :status => :created, :location => @rmonitor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rmonitor.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /rmonitors/1
  # PUT /rmonitors/1.xml
  def update
    @rmonitor = Rmonitor.find_object(params[:id])

   respond_to do |format|
      if @rmonitor.update_attributes(params)
         flash[:notice] = "Website Monitor edited successfully."
        format.html { redirect_to(show_path("dashboard",  current_user.attributes["username"])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rmonitor.errors, :status => :unprocessable_entity }
      end
    end 
  end

  # PUT /rmonitors/1/pause
  # PUT /rmonitors/1/pause.xml
  def pause
    @rmonitor = Rmonitor.find_object(params[:id])
    @rmonitor.pause
    flash[:success] = "Monitor paused."
    respond_to do |format|
      format.html { redirect_to(rmonitors_url) }
      format.xml  { head :ok }
    end
  end

 
  # PUT /rmonitors/1/restart
  # PUT /rmonitors/1/restart.xml
  def restart
    @rmonitor = Rmonitor.find_object(params[:id])
    @rmonitor.restart
    flash[:notice] = "Web site Monitor restarted successfully."
    respond_to do |format|
      format.html { redirect_to(rmonitors_url) }
      format.xml  { head :ok }
    end
  end


  # DELETE /rmonitors/1
  # DELETE /rmonitors/1.xml
  def destroy
    @rmonitor = Rmonitor.find_object(params[:id])
    @rmonitor.destroy
    flash[:success] = "Website was removed successfully"
    respond_to do |format|
      format.html { redirect_to(rmonitors_url) }
      format.xml  { head :ok }
    end
  end

 private

 def confirmed_email
     redirect_to(show_path("dashboard",  current_user.attributes["username"]),:notice => ('You have not confirmed your email address.' + view_context.link_to('Re-Send Verification email','/send_confirmation_email') + " to " + current_user.attributes["email"]).html_safe) unless current_user.attributes["confirmed_email"] 
 end

 def authenticate
   deny_access unless signed_in?
 end

 def must_have_payment_method
    redirect_to (show_path("payment_method",  "")) unless current_user.attributes["payment_info_on_file"]
 end

 def correct_user
   @rmonitor = Rmonitor.find_object(params[:id]) 
   @current_user = current_user
   if (@current_user.attributes["username"] != @rmonitor.attributes["tag"]) 
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless @current_user.admin?
   end
 end

 def admin_user
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless current_user.admin?
 end
end
