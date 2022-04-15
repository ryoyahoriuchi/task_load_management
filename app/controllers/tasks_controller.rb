class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update show destroy suggestion]
  before_action :authenticate_user!
  before_action :set_create_graph_area, only: %i[show]
  before_action :set_suggest_graph, only: %i[suggestion]

  def index
    @tasks = Task.where(user_id: current_user.id)
    if params[:label].present?
      @tasks = @tasks.with_labels.search_with_id(params[:label][:label_ids])
    end

    @events = Event.where(task_id: @tasks.pluck(:id))

    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
    @task.task_items.build
    @task.build_event
  end

  def create
    @task = current_user.tasks.build(task_params)
    hash_label = {}
    params[:task][:label_ids].each do |label|
      hash_label[:label_ids] = label.split(",").flatten
    end
    @task.attributes = hash_label
    if params[:back]
      render :new
    else
      if @task.save
        respond_to do |format|
          format.html { redirect_to task_path(@task.id), notice: I18n.t('views.messages.create_task') }
          format.js
        end
      else
        respond_to do |format|
          format.js { render :new }
        end
      end
    end
  end

  def suggestion
    if params[:commit] == I18n.t('helpers.submit.create')
      @task = current_user.tasks.build(task_params)
      render :new if @task.invalid?
    else
      @task = Task.find(params[:id])
      @task.attributes = task_params
      render :edit if @task.invalid? || @task.task_items.any?(&:invalid?)
    end
  end

  def edit
  end

  def update
    revision_params = task_params
    revision_params[:label_ids].map!{|x| x.split(",").sort}.flatten!
    if params[:back]
      render :edit
    else
      if @task.update(revision_params)
        redirect_to task_path(@task.id), notice: I18n.t('views.messages.updated_task')
      else
        render :edit
      end
    end
  end

  def show
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
    params.require(:task).permit(
      :title,
      :overview,
      :status,
      { label_ids: [] },
      task_items_attributes: [:id, :item, :level, :_destroy],
      event_attributes: [:id, :start_time_on, :end_time_on, :_destroy]
    )
  end

  def set_create_graph_area
    #各要素までの各々の面積求める〇
    @task_items = TaskItem.create_sorted.where(task_id: params[:id])
    quota_area = {0 => 0}
    pre_task_level = 0
    @task_items.each_with_index do |task_item, i|
      quota_area[i] = (pre_task_level + task_item.level) / 2.0 if pre_task_level != 0
      pre_task_level = task_item.level
    end
    sum_area = quota_area.values.inject(:+)

    #要件-レベルグラフを作成〇
    @graph_values = {}
    total_level = 0
    @task_items.each_with_index do |task_item, i|
      @graph_values[i] = task_item.level
      total_level += task_item.level
    end
    period = (@task.event[:end_time_on] - @task.event[:start_time_on]).to_i
    full_load = total_level.to_f
    
    #日々のノルマを計算
    @quota = {}
    day_quota = (sum_area / period).round(2)
    period.times do |i|
      area = day_quota * (i+1)
      quota_area.each_pair do |key, val|
        if area < val
          tilt = @task_items[key][:level] - @task_items[key - 1][:level]
          intercept = @task_items[key - 1][:level]
          a = tilt / 2.0
          b = intercept
          c = area.round(2) * -1
          quadratic_equation(a, b, c)

          x = @x.select{|num| num <= 1 && num > 0 }
          x_value = key - 1 + x[0].round(2)
          y_value = tilt * x[0].round(2) + intercept

          quota = @graph_values.select{|k, v| k < x_value}
          quota[x_value] = y_value.round(2)

          break @quota[i] = quota
        else
          area -= val
        end
      end
    end
    #グラフに引き渡す値に修正
    @array_graph = []
    count = 0
    @quota.each_with_index do |k, i|
      hash_graph = {}
      hash_graph[:name] = "day#{i + 1}"
      hash_graph[:data] = @quota[i]
      @array_graph[i] =  hash_graph
      count = i
    end
    @array_graph[count + 1] = {name: "day#{count + 2}", data: @graph_values}
  end

  def set_suggest_graph
    start_on = Date.parse(params[:task][:event_attributes]["start_time_on"])
    end_on = Date.parse(params[:task][:event_attributes]["end_time_on"])
    period = (end_on - start_on).to_i

    @task_items = {}
    count = 0
    params[:task][:task_items_attributes].each do |param|
      @task_items[count] = param[1]["level"].to_i
      count += 1
    end
    
    quota_area = {0 => 0}
    pre_task_level = 0
    @task_items.each_with_index do |task_item, i|
      quota_area[i] = (pre_task_level + task_item[1]) / 2.0 if pre_task_level != 0
      pre_task_level = task_item[1]
    end
    sum_area = quota_area.values.inject(:+)

    @graph_values = @task_items
    total_level = @task_items.values.inject(:+)
    full_load = total_level.to_f

    @quota = {}
    day_quota = (sum_area / period).round(2)
    period.times do |i|
      area = day_quota * (i+1)
      quota_area.each_pair do |key, val|
        if area < val
          tilt = @task_items[key] - @task_items[key - 1]
          intercept = @task_items[key - 1]
          a = tilt / 2.0
          b = intercept
          c = area.round(2) * -1
          quadratic_equation(a, b, c)

          x = @x.select{|num| num <= 1 && num > 0 }
          x_value = key - 1 + x[0].round(2)
          y_value = tilt * x[0].round(2) + intercept

          quota = @graph_values.select{|k, v| k < x_value}
          quota[x_value] = y_value.round(2)

          break @quota[i] = quota
        else
          area -= val
        end
      end
    end
    @array_graph = []
    count = 0
    @quota.each_with_index do |k, i|
      hash_graph = {}
      hash_graph[:name] = "day#{i + 1}"
      hash_graph[:data] = @quota[i]
      @array_graph[i] =  hash_graph
      count = i
    end
    @array_graph[count + 1] = {name: "day#{count + 2}", data: @graph_values}
  end

  def quadratic_equation(a, b, c)
    @x = []
    if (a != 0)
      b /= a
      c /= a
      if (c != 0)
        b /= 2
        d = b * b - c
        if (d > 0)
          if (b > 0)
            @x << -b - Math::sqrt(d)
          else
            @x << -b + Math::sqrt(d)
          end
          @x << (c / @x[0])
        elsif (d < 0)
          @x << -b
          @x << Math::sqrt(-d)
        else
          @x << -b
        end
      else
        @x << -b
      end
    elsif (b != 0)
      @x << (-c / b)
    else
      @x << 0
    end
  end
end