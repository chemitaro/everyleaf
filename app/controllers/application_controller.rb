class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :before_login

  def before_login
    redirect_to(new_session_path) unless logged_in?
  end
  def access_block_admin
    unless current_user_admin?
      flash[:danger] = '不正なアクセスです'
      redirect_to(tasks_path) 
    end
  end
  def access_block_user
    unless current_user.id == params[:id].to_i
      flash[:danger] = '不正なアクセスです'
      redirect_to(tasks_path) 
    end
  end
  
  
end
