class Admin::UsersController < ApplicationController
  before_action :admin_only
  def index
    @users = User.all
    @task_count = Task.group(:user_id).count
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(admin_user_params)
    if @user.save
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
    Task.where(user_id: @user.id).delete_all if @user.tasks.present?
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to(admin_users_path)
  end
  private
  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  def admin_only
    unless current_user_admin?
      flash[:danger] = '不正なアクセスです'
      redirect_to(tasks_path) 
    end
  end
  
  
  
  
  
end
