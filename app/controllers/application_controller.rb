class ApplicationController < ActionController::Base
  before_filter :authorize, :except => :login
  protect_from_forgery


protected
 def authorize
  unless session[:user]
    session[:original_uri] = request.request_uri
    flash[:notice] = "Please log in"
    #redirect_to :controller => 'admin', :action => 'login'
    redirect_to '/login'
  end
 end 
end
