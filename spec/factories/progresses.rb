FactoryBot.define do
  factory :progress do
    CreateProgresses { "MyString" }
    day { 1 }
    percent { 1.5 }
    task { nil }
  end
end
