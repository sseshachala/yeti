class PagesController < ApplicationController
  def home
    if signed_in?
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
    end
  end

  def contact
  end

  def support
  end

  def tos
  end

  def aboutus
  end

end
