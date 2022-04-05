class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update show destroy ]

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
        redirect_to root_path, notice: "登録しました"
      else
        render :new
      end
    end
  end

  def suggestion
    #set_task を省いた　idがない場合があるが、set_taskメソッドで分岐させた
    @task = Task.new(task_params) #unless params[:id] 書いたらupdate出来ない
    @task.id = params[:id]
    render :new if @task.invalid? #editでもnewに戻るため分岐が必要, task_itemでもバリデーション発生させたい
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

  def set_task
    @task = Task.find(params[:id]) if params[:id]
  end

  def task_params
    params.require(:task).permit(:title, :overview, :status, task_items_attributes: [:item, :level, :_destroy]) #:idを書くとeditできるが、重複データが生成される
  end

end
