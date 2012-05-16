FactoryGirl.define do
  factory :user do
    ignore do
      first_name { Faker::Name.first_name }
      last_name  { Faker::Name.last_name  }
    end

    full_name             { first_name + " " + last_name }
    email                 { "#{first_name}_#{last_name}@gmail.com".downcase }
    display_name          { (first_name + last_name).downcase.gsub(/[^a-z]/,"") }
    password              "somepassword"
    password_confirmation "somepassword"
  end
end
