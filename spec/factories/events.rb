FactoryBot.define do
  factory :first_event, class: Event do
    start_time_on { "2022-04-11" }
    end_time_on { "2022-04-12" }
    task { nil }
  end

  factory :second_event, class: Event do
    start_time_on { "2022-04-20" }
    end_time_on { "2022-04-25" }
    task { nil }
  end

  factory :third_event, class: Event do
    start_time_on { "2022-04-26" }
    end_time_on { "2022-05-02" }
    task { nil }
  end
end
