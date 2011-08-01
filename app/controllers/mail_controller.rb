class MailController < ApplicationController
  require 'mail'

  def receiver
    message = Mail.new(params[:message])
    to   = "UTF-8"
    from = "iso-8859-5"
    Rails.logger.fatal Iconv.conv(to, from, message.subject) #print the subject to the logs
    Rails.logger.fatal Iconv.conv(to, from, message.body.decoded) #print the decoded body to the logs

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end
