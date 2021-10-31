FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user@email.com" }
    password_digest { "password" }
    admin {false}
  end
end
