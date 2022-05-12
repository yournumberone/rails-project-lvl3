class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image

  validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 1000}
  validates :image, attached: true, size: { less_than: 5.megabytes, message: 'too_large_image' }
end
