class Item < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :price, presence: true, length: { maximum: 255 }
  validates :stock, presence: true, length: { maximum: 255 }
  
  mount_uploader :photo, PhotoUploader
end
