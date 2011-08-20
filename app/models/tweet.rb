class Tweet < ActiveRecord::Base
  belongs_to :offer

  class << self
    def get
      offers = Offer.today

      offers.each do |offer|
        next if Tweet.tweeted?(offer)
        Tweet.create(:offer => offer)
        return "#{offer.title} | #{offer.href}"
      end

      nil
    end

    def tweeted?(offer)
      offer.tweet.present?
    end
  end
end