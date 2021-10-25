class TasksController < ApplicationController
  def index
    @tasks = Task.all
    if params[:select].present?
      if params[:select][:search].present?
        @tasks = @tasks.where('task_name like ?', "%#{params[:select][:search]}%")
      end
      statuses = []
      statuses << "未着手" if params[:select][:status_not] == "1"
      statuses << "着手中" if params[:select][:status_working] == "1"
      statuses << "完了" if params[:select][:status_fin] == "1"
      @tasks = @tasks.where(status: statuses)

      if params[:select][:sort].present?
        @tasks = @tasks.order(params[:select][:sort] => params[:select][:direction].to_sym) 
      end
    end
    
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(tasks_params)
    if @task.save
      flash[:notice] = 'タスクを登録しました'
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end
  def show
    @task = Task.find(params[:id])
  end
  def edit
    @task = Task.find(params[:id])
  end
  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_params)
      flash[:notice] = 'タスクを編集しました'
      redirect_to tasks_path
    else
      render :edit
    end
  end
  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice] = 'タスクを削除しました'
    redirect_to tasks_path
  end
  private
  def tasks_params
    params.require(:task).permit(:task_name, :content, :status, :deadline,)
  end
end
