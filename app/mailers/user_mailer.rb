class UserMailer < ActionMailer::Base
 
  default :from => "whisper.monitor@gmail.com"

 def confirmation_email(user,domain)
    @domain = domain
    @user = user
    @url  = confirmation_url
    mail(:to => user.email, :subject => "Please confirm your email address")
  end

 def confirmation_url
   "http://" + @domain + "/confirm/" + @user.confirmation_code 
 end

end
