# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence :email do |n|
		"user#{n}@example.com"
	end

  factory :user do
    name "User"
    email
    password "password"
    password_confirmation "password"
  end
end
