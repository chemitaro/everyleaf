class UsersController < ApplicationController
  skip_before_action :access_block_before_login, only: [:new, :create]
  before_action :access_block_after_login, only: [:new, :create]
  before_action :access_block_another_user, only: [:show]

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = '新規ユーザーを登録しました'
      redirect_to(tasks_path)
    else
      flash.now[:danger] = '正しい情報を入力してください'
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
