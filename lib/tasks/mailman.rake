require "gmail"

@gmail = Gmail.new('groupon.receiver@gmail.com', 'OoX$,QG@Nr^5{,*J')

namespace :mail do
  desc 'receive email'
  task :receive => :environment do
    %w[daily@e.groupon.ru daily@deals.groupon.ru].each do |address|
      @gmail.inbox.emails(:unread, :from => address).each do |email|
        DailyMail.receive(email)
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