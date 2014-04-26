class Task < ActiveRecord::Base
	validates :name, presence: true
	validates :priority, presence: true
	belongs_to :user
	after_destroy :add_exp

	private

		def add_exp
			self.user.add_exp
			if self.user.level_up?
				self.user.level_up
			end
		end

end
