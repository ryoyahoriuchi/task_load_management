FactoryBot.define do
  factory :first_user, class: User do
    name { 'admin_user' }
    email { 'admin_user@mail.com' }
    password { 'password' }
    admin { true }
  end
end
