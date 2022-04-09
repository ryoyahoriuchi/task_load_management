class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update show destroy suggestion]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.task_items.build
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: I18n.t('views.messages.create_task')
      else
        render :new
      end
    end
  end

  def suggestion
    if params[:commit] == I18n.t('helpers.submit.create')
      @task = Task.new(task_params)
      render :new if @task.invalid?
    else
      @task = Task.find(params[:id])
      @task.attributes = task_params
      render :edit if @task.invalid? || @task.task_items.any?(&:invalid?) #task_itemのバリデーション働いてない
    end
  end

  def edit
  end

  def update
    if params[:back]
      render :edit
    else
      if @task.update(task_params)
        redirect_to task_path(@task.id), notice: I18n.t('views.messages.updated_task')
      else
        render :edit
      end
    end
  end

  def show
    @task_items = TaskItem.where(task_id: params[:id])
    @memo = []
    @memos = @task_items.map do |task_item|
      @memo = task_item.memos.build
      task_item.memos
    end
    @memos = @memos.flatten
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t('views.messages.deleted_task')
  end

  private

  def set_task
    @task = Task.find(params[:id]) if params[:id]
  end

  def task_params
    params.require(:task).permit(:title, :overview, :status, task_items_attributes: [:id, :item, :level, :_destroy])
  end

end
