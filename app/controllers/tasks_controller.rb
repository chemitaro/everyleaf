class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(tasks_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを登録しました'
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
    task = Task.find(params[:id])
    if task.update(tasks_params)
      redirect_to tasks_path, notice: 'タスクを編集しました'
    else
      render :edit
    end
  end
  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end
  private
  def tasks_params
    params.require(:task).permit(:task_name, :content)
  end
end
