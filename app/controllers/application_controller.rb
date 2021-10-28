class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :before_login

  def before_login
    redirect_to(new_session_path) unless logged_in?
  end
end
