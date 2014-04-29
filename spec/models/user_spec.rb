require 'spec_helper'

describe User, '.new_remember_token' do
	it 'generates a random URL-safe base64 string' do
		result = User.new_remember_token

		expect(result.class).to eq(String)
	end
end

describe User, '.hash' do
	it 'returns the hex-encoded hash value of a given string' do
		result = User.hash('string')

		expect(result.class).to eq(String)
  end
end

describe User, '#next_level' do
	it 'calculates how many exp a user needs until next level' do
		user = create(:user)
		expect(user.next_level).to eq(1000)

		user.update_attribute(:level, 2)
		expect(user.next_level).to eq(2000)

		user.update_attribute(:level, 3)
		expect(user.next_level).to eq(3000)

		user.update_attribute(:level, 4)
		expect(user.next_level).to eq(5000) # Fibonacci exp progression
	end
end

describe User, '#level_up?' do
	it 'returns true if user has enough exp to gain a level' do
		user = create(:user)
		expect(user.level_up?).to eq(false)

		user.update_attribute(:exp, 1000)
		expect(user.level_up?).to eq(true)
	end
end

describe User, '#add_exp' do
	it 'increases users exp total by 100' do
		user = create(:user)
		expect(user.exp).to eq(0)

		user.add_exp
		expect(user.exp).to eq(100)
	end
end

describe User, '#level_up' do
	it 'increases users level by one' do
		user = create(:user)
		expect(user.level).to eq(1)

		user.level_up
		expect(user.level).to eq(2)
	end
end




