class UserMailer < ActionMailer::Base

  default :from => "South Munn <southmunn@southmunn.com>"

 def confirmation_email(user,domain)
    @domain = domain
    @user = user
    @url  = confirmation_url
    mail(:to => user.email, :subject => "Please confirm your email address")
  end

 def confirmation_url
   "http://" + @domain + "/confirm/" + @user.confirmation_code 
 end
 
 def password_reset_email(email,domain)
  @domain = domain
   
   @url = password_reset_code_url(email)
   @email = email
  if User.found_user_with_forgotten_email?(@email)
   mail(:to => @email, :subject => "Reset Your Yeti Password")
  end
 end

 def password_reset_code_url(email)
  "http://" + @domain + "/reset_password/" + User.password_reset_code(email)  
 end
end
