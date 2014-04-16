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

    factory :user_with_tasks do
    	ignore do
    		tasks_count 5
    	end

    	after(:create) do |user, evaluator|
    		create_list(:complete_task, evaluator.tasks_count, user: user)
    	end
    end
  end
end
