FactoryBot.define do
  factory :first_label, class: Label do
    genre { "red" }
  end

  factory :second_label, class: Label do
    genre { "blue" }
  end

  factory :third_label, class: Label do
    genre { "green" }
  end
end