class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :password_digest, :session_token, uniqueness: true
  after_initialize :ensure_session_token
  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  has_many :cats,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: :Cat

  has_many :cat_rental_requests
end
