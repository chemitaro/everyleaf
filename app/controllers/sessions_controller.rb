class SessionsController < ApplicationController
  skip_before_action :access_block_before_login, only: [:new, :create]
  before_action :access_block_after_login, only: [:new, :create]

  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'ログインしました'
      redirect_to(tasks_path)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to(new_session_path)
  end
  
end
