class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: {allow_nil: true, minimum: 6}
  attr_reader :password

  after_initialize :ensure_session_token

  has_many :subs,
    foreign_key: :moderator_id, 
    primary_key: :id, 
    class_name: :Sub,
    dependent: :destroy
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user 
    return user if user.is_password?(password) 
    nil 
  end

  def self.generate_session_token 
    SecureRandom::urlsafe_base64
  end

  def reset_session_token! 
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password 
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token 
    self.session_token ||= reset_session_token!
  end
end
