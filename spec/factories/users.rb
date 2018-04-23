FactoryBot.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |n| "john#{n}@vanhack.test" }
    password "secret$password"
  end
end
