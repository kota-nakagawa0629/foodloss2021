class Item < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}, length: { maximum: 255 }
  validates :stock, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}, length: { maximum: 255 }
  
  mount_uploader :photo, PhotoUploader

end

