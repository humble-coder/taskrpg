class Task < ActiveRecord::Base
	validates :name, presence: true
	validates :priority, presence: true
end
