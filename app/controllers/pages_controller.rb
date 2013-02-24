class PagesController < ApplicationController

  def home
    if signed_in?
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
    end
  end

  def contact
      contact_url = "/contact"
      @breadcrumb = {"Contact" => contact_url}
  end

  def support
      support_url = "/support"
      @breadcrumb = {"Support" => support_url}
  end

  def tos
      tos_url = "/tos"
      @breadcrumb = {"Terms of Service" => tos_url}
  end

  def aboutus
      about_us_url = "/aboutus"
      @breadcrumb = {"About us" => about_us_url}
  end

end
