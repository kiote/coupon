require "gmail"

@gmail = Gmail.new('groupon.receiver@gmail.com', 'OoX$,QG@Nr^5{,*J')

def receive(email)
  body = email.body
  str = body.decoded
  str.force_encoding('iso-8859-5')
  dm = DailyMail.create(:message => str.encode('utf-8'))
  adv, hrf = dm.advertisements

  adv.each_with_index do |ad, index|
    Offer.create(:daily_mail => dm, :title => ad, :href => hrf[index]) unless Offer.today.find_by_href(hrf[index]).present?
  end
end

namespace :mail do
  desc 'receive email'
  task :receive => :environment do
    %w[daily@e.groupon.ru daily@deals.groupon.ru].each do |address|
      @gmail.inbox.emails(:unread, :from => address).each do |email|
        receive(email)
      end
    end
  end
end

namespace :twitter do
  desc 'make a tweet'
  task :tweet => :environment do
    GETTER = lambda do
      Tweet.get
    end
    begin
      client = Robotwitter::Robot.new("#{Rails.root}/config", 'kuponobot', &GETTER)
      client.send_message("_msg_")
    rescue
    end
  end
end