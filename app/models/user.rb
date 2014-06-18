class User < ActiveRecord::Base
 	has_many :sale_houses, dependent: :destroy
 	has_many :rent_houses, dependent: :destroy
  	before_save { self.email = email.downcase }
  	before_create :create_remember_token
  	before_create { generate_token(:auth_token) }
  	validates :name, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  	has_secure_password
  		validates :password, length: { minimum: 6 }
	
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

	def send_password_reset
  		generate_token(:password_reset_token)
  		self.password_reset_sent_at = Time.zone.now
  		self.password = SecureRandom.urlsafe_base64
  		save!
  		UserMailer.password_reset(self).deliver
	end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

	def generate_token(column)
  		begin
    	self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
	end
end
