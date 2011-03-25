class AdminController < ApplicationController
  def login
     if request.post?
        if authenticate(params[:name],params[:password])
           session[:user] = @@username
           uri = session[:original_uri]           
           session[:original_uri] = nil 
           redirect_to(uri || {:action => "index"})
        else 
           flash.now[:notice] = "Invalid username or password"
        end
     end
  end

  def logout
    session[:user] = nil
  end

  def index
   redirect_to :controller => 'ragios',:action => 'monitors'
  end

  def authenticate(name,password)
     if @@username == name
        if @@password == password
          return TRUE
        else 
          return FALSE
        end
     end
  end

end
