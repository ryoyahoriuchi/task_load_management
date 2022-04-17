FactoryBot.define do
  factory :first_user, class: User do
    name { 'jack' }
    email { 'jack@mail.com' }
    password { 'password' }
    admin { false }
    confirmed_at { Date.today }
  end

  factory :second_user, class: User do
    name { 'abcde' }
    email { 'abcde@mail.com' }
    password { 'password' }
    admin { false }
    confirmed_at { Date.today }
  end

  factory :third_user, class: User do
    name { 'admin_user' }
    email { 'admin_user@mail.com' }
    password { 'password' }
    admin { true }
    confirmed_at { Date.today }
  end
end
