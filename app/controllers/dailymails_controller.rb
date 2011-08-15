class DailyMailsController < ApplicationController
  def index
    @daily_mails = DailyMail.all
  end

end