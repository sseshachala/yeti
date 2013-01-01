class PagesController < ApplicationController
  def home
    if signed_in?
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
    end
  end

  def contact
  end

  def login
  end

  def dashboard
  end

  def aboutus
  end

end
