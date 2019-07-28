FactoryBot.define do
  factory :location do
    name { "MyString" }
    street_address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    type { 1 }
  end
end
