class User < ActiveRecord::Base
  has_many :sale_houses, dependent: :destroy
  has_many :rent_houses, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create { generate_token(:auth_token) }
  after_save :send_comfirm_mail

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
    format:     { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  has_secure_password

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

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
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

  def send_comfirm_mail
    UserMailer.confirm(:email).deliver
  end
end
