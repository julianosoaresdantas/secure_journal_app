class JournalEntry < ApplicationRecord
  # Add this line
  belongs_to :user

  # Optional: Add validations for title and content
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  encrypts :content
end
