class OffersController < ApplicationController
  def index
    @offers = Offer.order("id DESC").all
  end
end
