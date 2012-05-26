class ReportsController < ApplicationController
before_filter :authenticate
before_filter :must_have_payment_method, :only => [:new,:show,:create,:edit,:update, :destroy, :restart, :stop]
before_filter :correct_tag, :only => [ :destroy, :restart, :stop]
before_filter :correct_user, :only => [:show,:edit,:update]
before_filter :admin_user, :only => [:index]
before_filter :confirmed_email, :only => [:new,:create, :edit, :update]

  # GET /reports
  # GET /reports.xml
  def index
     @reports = Report.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.xml
  def show
    @report = Report.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

 
# PUT /reports/1/stop
# PUT /reports/1/stop.xml
  def stop
    @report = Report.new
    @report.stop(params[:id])
    flash[:success] = "Status Reporting Stopped."
    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end

 # PUT /reports/1/restart
  # PUT /reports/1/restart.xml
  def restart
    @report = Report.new
    @report.restart(params[:id])
    flash[:success] = "Status Reporting Restarted."
    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end

  # GET /reports/new
  # GET /reports/new.xml
  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report }
    end
  end


  # GET /reports/1/edit
  def edit
    @report = Report.find_object(params[:id])
  end

  # POST /reports
  # POST /reports.xml
  def create
    @report = Report.new(params[:report])

    respond_to do |format|
      if @report.save(current_user)
        format.html { redirect_to(@report, :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.xml
  def update
    @report = Report.find_object(params[:id])
    @report.contact = current_user.attributes["email"]
    respond_to do |format|
      if @report.update_attributes(params)
        format.html { redirect_to(@report, :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    @report = Report.new
    @report.destroy(current_user.attributes["username"]) unless ((current_user.attributes["username"]  != params[:id]) || current_user.admin?)
    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end

 private

 def confirmed_email
     redirect_to(show_path("dashboard",  current_user.attributes["username"]),:notice => 'You have not confirmed your email address.') unless current_user.attributes["confirmed_email"] 
 end

 def authenticate
   deny_access unless signed_in?
 end

 def must_have_payment_method
   redirect_to (show_path("payment_method",  "")) unless current_user.attributes["payment_info_on_file"]
 end

 def correct_tag
   if (@current_user.attributes["username"] != params[:id]) 
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless @current_user.admin?
   end
 end

 def correct_user
   @report = Report.find_object(params[:id]) 
   @current_user = current_user
   if (@current_user.attributes["username"] != @report.attributes["tag"]) 
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless @current_user.admin?
   end
 end

 def admin_user
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless current_user.admin?
 end

end
