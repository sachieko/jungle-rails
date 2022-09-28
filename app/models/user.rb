class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, if: :password_digest_changed?
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
    emailQuery = email.downcase.strip
    @user = User.find_by_email(emailQuery)
    p @user
    @user && @user.authenticate(password) ? @user : nil
  end

end
