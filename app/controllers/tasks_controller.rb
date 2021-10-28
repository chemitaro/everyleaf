class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
    # if params[:select].present?
    #   @tasks = @tasks.search(params[:select]) if params[:select][:search].present?
    #   @tasks = @tasks.status(params[:select])
    #   # @tasks = @tasks.sort_index(params[:select]) if params[:select][:sort_index].present?
    # end
    # @tasks = @tasks.search(params[:select]) if params[:select].presence?

    # @tasks = @tasks.search(params[:select]) if params[:select].present?

    if params[:select].present?
      @tasks = @tasks.search_status(params[:select][:search], params[:select][:status]) if params[:select][:search].present? && params[:select][:status].present?
      @tasks = @tasks.search(params[:select][:search]) if params[:select][:search].present?
      @tasks = @tasks.status(params[:select][:status]) if params[:select][:status].present?
    end

    @tasks = @tasks.order(deadline: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :desc) if params[:sort_priority]
    @tasks = @tasks.page(params[:page]).per(5)
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(tasks_params)
    @task.user_id = current_user.id
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
  def params_select
    params[:select]
  end

  private
  def tasks_params
    params.require(:task).permit(:task_name, :content, :status, :priority, :deadline,)
  end
end
