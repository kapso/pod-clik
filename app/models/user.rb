class User < ActiveRecord::Base
  extend Enumerize

  authenticates_with_sorcery!

  belongs_to :school

  normalize_attribute :first_name, :last_name, :phone_number, :email, with: [:blank, :squish]

  enumerize :state_enum, in: { active: 1, inactive: 2 }, default: :active, predicates: true, scope: true

  default_values emailable: true, phone_country_code: '1', phone_verified: false

  validates :first_name, :phone_number, :email, presence: true
  validates :email, email_format: { message: 'is not valid' }, allow_blank: false, uniqueness: true
  # validates :phone_number, telephone: true

  before_create :generate_remember_me_token, :generate_phone_verify_code
  after_create :sms_phone_verify_code
  before_update :generate_remember_me_token, if: :crypted_password_changed?

  def self.find_by_auth_token(token)
    where(remember_me_token: token).first
  end

  def password_match?(password)
    Sorcery::CryptoProviders::BCrypt.matches?(self.crypted_password, password, self.salt)
  end

  def signin!
    update(last_login_at: Time.now)
  end

  def signout!
    now = Time.now
    update(last_logout_at: now, last_activity_at: now)
  end

  private
  def generate_remember_me_token
    begin
      self.remember_me_token = SecureRandom.urlsafe_base64(25)
    end while User.where(remember_me_token: self.remember_me_token).pluck(:id).present?
  end

  def generate_phone_verify_code
    self.phone_verify_code = rand(1000..99999).to_s
  end

  def sms_phone_verify_code
    hash = { from: Settings.twilio.phone_number, to: phone_number, body: "Podclik auth code: #{phone_verify_code}" }
    Twilio::REST::Client.new(Settings.twilio.account_sid, Settings.twilio.auth_token).account.sms.messages.create(hash)
  rescue => e
    logger.error "[User] Could not send sms verify code for user=#{id}, error: #{e.message}"
  end
end
