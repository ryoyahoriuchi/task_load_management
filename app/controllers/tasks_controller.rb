class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update show destroy ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to root_path, notice: "登録しました"
      else
        render :new
      end
    end
  end

  def suggestion
    set_task if params[:id]
    @task = Task.new(task_params)
    @task.id = params[:id]
    render :new if @task.invalid?
  end

  def edit
  end

  def update
    if params[:back]
      render :edit
    else
      if @task.update(task_params)
        redirect_to tasks_path, notice: "タスクを編集しました"
      else
        render :edit
      end
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :overview, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
