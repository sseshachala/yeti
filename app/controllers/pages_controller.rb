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
      PageMailer.contact_us_email(params).deliver
       flash[:success] = "The message has been sent we will get back to you 4 - 6 hours."
      respond_to do |format| 
       format.html { redirect_to(show_path("contact",  ""))}
      end
  end

  def faq
       @page_title = "FAQ - " + @page_title
      support_url = "/faq"
      @breadcrumb = {"FAQ" => faq_url}
  end

  def tos
      @page_title = "Terms Of Service - " + @page_title
      tos_url = "/tos"
      @breadcrumb = {"Terms of Service" => tos_url}
  end

  def privacy
      @page_title = "Privacy - " + @page_title
      tos_url = "/privacy"
      @breadcrumb = {"privacy" => privacy_url}
  end

  def aboutus
      @page_title = "About Us - " + @page_title
      about_us_url = "/aboutus"
      @breadcrumb = {"About us" => about_us_url}
  end

end
