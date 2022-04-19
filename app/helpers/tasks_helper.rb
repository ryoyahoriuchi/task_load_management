module TasksHelper
  def choose_new_or_edit
    case action_name
    when 'new', 'create'
      suggestion_tasks_path
    when 'edit', 'update'
      suggestion_task_path
    end
  end

  def suggestion_new_or_edit
    if @task.id?
      task_path
    else
      tasks_path
    end
  end

  def suggestion_form_method
    @task.id ? 'patch' : 'post'
  end
end
