class GrouponsController < ApplicationController
  def index
    @groupons = Groupon.all
  end

end
