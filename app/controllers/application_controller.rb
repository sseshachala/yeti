class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  include RmonitorsHelper
  before_filter :include_ga

  def include_ga
   @tracking_id = @@tracking_id
   @ga_sitedomain = @@ga_sitedomain
  end
end
