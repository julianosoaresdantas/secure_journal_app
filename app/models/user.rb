# app/models/user.rb
class User < ApplicationRecord
  devise :two_factor_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :journal_entries, dependent: :destroy
end
