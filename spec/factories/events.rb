FactoryBot.define do
  factory :first_event, class: Event do
    start_time_on { '2022-04-11' }
    end_time_on { '2022-04-12' }
    task { nil }
  end

  factory :second_event, class: Event do
    start_time_on { '2022-04-20' }
    end_time_on { '2022-04-25' }
    task { nil }
  end

  factory :third_event, class: Event do
    start_time_on { '2022-04-26' }
    end_time_on { '2022-05-02' }
    task { nil }
  end

  factory :fourth_event, class: Event do
    t = Time.now
    start_time_on { "#{t.year}-#{t.month}-#{t.day}" }
    end_time_on { "#{t.year}-#{t.month}-#{t.day + 2}" }
    task { nil }
  end

  factory :fifth_event, class: Event do
    t = Time.now
    start_time_on { "#{t.year}-#{t.month}-#{t.day - 1}" }
    end_time_on { "#{t.year}-#{t.month}-#{t.day}" }
    task { nil }
  end
end
