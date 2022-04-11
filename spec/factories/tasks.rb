FactoryBot.define do
  factory :first_task, class: Task do
    title { 'title01' }
    overview { 'overview01' }
    status { 0 }
  end

  factory :second_task, class: Task do
    title { 'sample' }
    overview { 'summary' }
    status { 1 }
  end

  factory :third_task, class: Task do
    title { 'ruby' }
    overview { 'code' }
    status { 2 }
  end
end