# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "Some Task"
    priority 1
    user

    factory :complete_task do
    	complete true
    end
  end
end
