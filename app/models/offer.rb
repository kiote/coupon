class Offer < ActiveRecord::Base
  belongs_to :daily_mail

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end