class User < ApplicationRecord
  enum category: { user: 0, shop: 1 }
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :items
  has_many :trades
  has_many :likes, through: :trades, source: :item
  
  def trade(item)
    self.trades.find_or_create_by(item_id: item.id)
  end

  def untrade(item)
    trade = self.trades.find_by(item_id: item.id)
    trade.destroy if trade
  end

  def like?(item)
    self.likes.include?(item)
  end
  
  def feed_likes
    Item.where(user_id: self.like_ids )
  end
  
end
