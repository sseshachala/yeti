class UserMailer < ActionMailer::Base

 def contact_us_email(params)
    @params = params
    mail(:from=> @params[:email], :to => "support@southmunn.com", :subject => @params[:subject])
  end

end
