class OffersController < ApplicationController
  def index
    @offers = Offer.search(params[:search])
      .paginate(:page => params[:page], :per_page => 40)
      .order("id DESC")
      .all
  end
end
