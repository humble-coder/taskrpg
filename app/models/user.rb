class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
  after_create :create_options
	has_secure_password
	has_many :tasks, -> { order(priority: :asc) }, dependent: :destroy
	validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :validate_password?
  validates :password_confirmation, presence: true, :if => :validate_password?
  has_many :options, -> { order(value: :asc) }, dependent: :destroy

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.hash(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  def validate_password?
    password.present? || password_confirmation.present? || self.new_record?
  end

  def next_level
    if self.level == 1 || self.level == 2
      self.level * 1000
    else
      ((self.level - 2) * 1000) + ((self.level - 1) * 1000)
    end
  end

  def level_up?
    self.exp >= self.next_level
  end

  def add_exp
    self.update_attribute(:exp, self.exp += 100)
  end

  def level_up
    self.update_attribute(:level, self.level += 1)
  end

  private

    def create_remember_token
    	self.remember_token = User.hash(User.new_remember_token)
    end

    def create_options
      user = self
      5.times do |index|
        Option.create(value: index + 1, user_id: user.id)
      end
    end
end
