# app/models/entry.rb
class Entry < ApplicationRecord
  belongs_to :user
  has_one_attached :image # Add this line

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end
