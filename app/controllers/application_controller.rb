class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :access_block_before_login

  def access_block_before_login
    redirect_to(new_session_path) unless logged_in?
  end
  def access_block_after_login
    redirect_to(tasks_path) if logged_in?
  end
  def access_block_non_admin
    unless current_user_admin?
      flash[:danger] = '不正なアクセスです'
      redirect_to(tasks_path) 
    end
  end
  def access_block_another_user
    unless current_user.id == params[:id].to_i
      flash[:danger] = '不正なアクセスです'
      redirect_to(tasks_path) 
    end
  end
end
