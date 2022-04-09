FactoryBot.define do
  factory :first_task_item, class: TaskItem do
    item { 'item01' }
    level { 1 }
  end

  factory :second_task_item, class: TaskItem do
    item { 'issue02' }
    level { 2 }
  end
end