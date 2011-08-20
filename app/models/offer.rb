class Offer < ActiveRecord::Base
  belongs_to :daily_mail
  has_one    :tweet

  scope :today, where('created_at >= ?', Date.today)

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end