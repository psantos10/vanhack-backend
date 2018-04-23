class User < ApplicationRecord
  has_secure_password

  # validations macros
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # returns user's fullname
  def name
    "#{first_name} #{last_name}"
  end
end
