class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    binding.irb
    @user = User.new(admin_user_params)
    binding.irb
    if @user.save
      binding.irb
      flash[:notice] = '新しいユーザーを作成しました'
      redirect_to(admin_user_path(@user.id))
    else
      flash[:danger] = 'ユーザーの作成に失敗しました！'
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(admin_user_params)
      flash[:notice] = 'ユーザー情報を更新しました'
      redirect_to(admin_user_path(@user.id))
    else
      flash[:danger] = 'ユーザーの更新に失敗しました'
      render :edit
    end
  end
  def destroy
    @user = User.find(params[:id])
    binding.irb
    @user.tasks.delete_all if @user.tasks.present?
    binding.irb
    @user.destroy
    binding.irb
    flash[:notice] = "ユーザーを削除しました"
    redirect_to(admin_users_path)
  end
  private
  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  
  
  

  
  
end
