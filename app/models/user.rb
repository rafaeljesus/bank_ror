class User < ApplicationRecord
  include BCrypt

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { in: 6..20 }

  def valid_password?(user_password)
    password == user_password
  end

  def as_json(options = {})
    super(options.merge(except: [:crypted_password]))
  end

  def password
    return nil unless self.crypted_password.present?
    @password ||= Password.new(crypted_password)
  end

  def password=(value)
    return unless value.present?
    @password = value
    self.crypted_password = Password.create(value)
  end
end
