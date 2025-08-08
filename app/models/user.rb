# app/models/user.rb
class User < ApplicationRecord
  # Add :two_factor_authenticatable to the list
  devise :two_factor_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :journal_entries, dependent: :destroy

  encrypts :otp_secret
  # A secret key to use with the authenticator
  # The column name is `otp_secret` by default.
  # You can change it by using `devise :two_factor_authenticatable, otp_secret_encryption_key: '...'
end
