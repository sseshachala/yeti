class RmonitorsController < ApplicationController
  # GET /rmonitors
  # GET /rmonitors.xml
  def index
    @rmonitors = Rmonitor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rmonitors }
    end
  end

  # GET /rmonitors/1
  # GET /rmonitors/1.xml
  def show
    @rmonitor = Rmonitor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rmonitor }
    end
  end

  # GET /rmonitors/new
  # GET /rmonitors/new.xml
  def new
    @rmonitor = Rmonitor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rmonitor }
    end
  end

  # GET /rmonitors/1/edit
  def edit
    @rmonitor = Rmonitor.find_object(params[:id])
  end

  # POST /rmonitors
  # POST /rmonitors.xml
  def create
    @rmonitor = Rmonitor.new(params[:rmonitor])

    respond_to do |format|
      if @rmonitor.save(current_user)
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
        format.html { redirect_to(@rmonitor, :notice => 'Rmonitor was successfully updated.') }
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
    flash[:success] = "Monitor restarted."
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
    flash[:success] = "Monitor destroyed."
    respond_to do |format|
      format.html { redirect_to(rmonitors_url) }
      format.xml  { head :ok }
    end
  end
end
