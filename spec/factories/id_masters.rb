FactoryBot.define do
  factory :id_master do
    id_type_id { 1 }
    name_on_id { "MyString" }
    id_number { "MyString" }
    reference_number { "MyString" }
    issue_date { "2022-10-24" }
    first_intermidiary_expiry { "2022-10-24" }
    second_intermidiary_expiry { "2022-10-24" }
    third_intermidiary_expiry { "2022-10-24" }
    exipry_date { "2022-10-24" }
    association :user
    front_image { "MyText" }
    back_image { "MyText" }
    status { false }
  end
end
