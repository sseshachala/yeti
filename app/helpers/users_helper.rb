module UsersHelper

 def gravatar_for(user, options = {:size => 50})
  gravatar_image_tag(user["email"].downcase, :alt => user["username"],
                                          :class => 'gravatar',
                                          :gravatar => options)
 end

 def add_payment_method
   redirect_to payment_method_path
 end
end
