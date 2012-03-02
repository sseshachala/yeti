class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "whisper.monitor@gmail.com"

 def confirmation_email(user)
    @user = user
    @url  = confirmation_url
    mail(:to => user.email, :subject => "Please confirm your email address")
  end

 def confirmation_url
  show_path("confirm",  @user.confirmation_code)
 end

end
