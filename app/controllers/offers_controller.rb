class OffersController < ApplicationController
  def index
    @offers = Offer.paginate(:page => params[:page], :per_page => 40).order("id DESC").all
  end
end
