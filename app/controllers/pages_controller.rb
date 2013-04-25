class PagesController < ApplicationController
 before_filter :start_page_title

 def start_page_title
  @page_title = "Website Uptime Monitoring | SouthMunn.com"
 end

  def home
     #@page_title = "Reliable " + @page_title
    if signed_in?
     redirect_to(show_path("dashboard",  current_user.attributes["username"]))
    end
  end

  def contact
       @page_title = "Contact Us - " + @page_title
      contact_url = "/contact"
      @breadcrumb = {"Contact" => contact_url}
  end

  def send_contact_message
       @page_title = "Contact Us - " + @page_title
      contact_url = "/contact"
      @breadcrumb = {"Contact" => contact_url}
      puts "email: " + params[:email]
      puts "name: " + params[:name]
      puts "message: " + params[:message]

      PageMailer.contact_us_email(params).deliver
      respond_to do |format|
       flash[:notice] = "The message has been sent we will get back to you 4 - 6 hours."
       format.html { render :action => "contact" }
      end
  end

  def support
       @page_title = "Support - " + @page_title
      support_url = "/support"
      @breadcrumb = {"Support" => support_url}
  end

  def tos
      @page_title = "Terms Of Service - " + @page_title
      tos_url = "/tos"
      @breadcrumb = {"Terms of Service" => tos_url}
  end

  def aboutus
      @page_title = "About Us - " + @page_title
      about_us_url = "/aboutus"
      @breadcrumb = {"About us" => about_us_url}
  end

end
