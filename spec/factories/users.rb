FactoryBot.define do
  factory :user do
    sequence(:fullname) { |e| "Person #{e}" }
    sequence(:email) { |e| "person#{e}@albert.com" }
    password { "123456" }
  end
end
