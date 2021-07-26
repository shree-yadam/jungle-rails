class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Class method to authenticate credentials entered by user for login
  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email email.strip.downcase
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
