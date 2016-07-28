class User < ApplicationRecord
  include BCrypt

  validates_confirmation_of :password, if: :password_present?
  validates_presence_of :password, on: :create
  validates_presence_of :email, uniqueness: true, on: :create
  validate :password_length

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

  private
  def password_length
    if password && password.length < 8
      errors.add(:password, 'password must be greather then 8')
    end
  end

  def password_present?
    !password.nil?
  end
end
