class InvoicesController < ApplicationController
 before_filter :authenticate
 before_filter :must_have_payment_method
 before_filter :correct_user, :only => [:show,:billing_history]
 before_filter :admin_user

  # GET /invoices
  # GET /invoices.xml
  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  def billing_history

  end

  # GET /invoices/new
  # GET /invoices/new.xml
  #def new
   # @invoice = Invoice.new

    #respond_to do |format|
     # format.html # new.html.erb
     # format.xml  { render :xml => @invoice }
    #end
  #end 

  # GET /invoices/1/edit
 # def edit
 #   @invoice = Invoice.find(params[:id])
 # end

  # POST /invoices
  # POST /invoices.xml
  #def create
   # @invoice = Invoice.new(params[:invoice])

    #respond_to do |format|
     # if @invoice.save
      #  format.html { redirect_to(@invoice, :notice => 'Invoice was successfully created.') }
       # format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
     # else
      #  format.html { render :action => "new" }
       # format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
     # end
   # end
 # end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  #def update
   # @invoice = Invoice.find(params[:id])

   # respond_to do |format|
    #  if @invoice.update_attributes(params[:invoice])
     #   format.html { redirect_to(@invoice, :notice => 'Invoice was successfully updated.') }
      #  format.xml  { head :ok }
    #  else
     #   format.html { render :action => "edit" }
      #  format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
     # end
   # end
  #end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  #def destroy
   # @invoice = Invoice.find(params[:id])
   # @invoice.destroy

   # respond_to do |format|
    #  format.html { redirect_to(invoices_url) }
     # format.xml  { head :ok }
    #end
  #end
 private 

  def authenticate
   deny_access unless signed_in?
 end
 
 def must_have_payment_method
    redirect_to (show_path("payment_method",  "")) unless current_user.attributes["payment_info_on_file"]
 end

 def correct_user
  # @rmonitor = Rmonitor.find_object(params[:id]) 
  # @current_user = current_user
  # if (@current_user.attributes["username"] != @rmonitor.attributes["tag"]) 
  #   redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless @current_user.admin?
  # end
 end

 def admin_user
     redirect_to(show_path("dashboard",  current_user.attributes["username"])) unless current_user.admin?
 end 

end
