require "gmail"

@gmail = Gmail.new('groupon.receiver@gmail.com', 'OoX$,QG@Nr^5{,*J')

namespace :mail do
    desc 'receive email'
    task :receive => :environment do
      @gmail.inbox.emails(:unread, :from => "daily@e.groupon.ru").each do |email|
        body = email.body
        str = body.decoded
        str.force_encoding('iso-8859-5')
        dm = DailyMail.create(:message => str.encode('utf-8'))
        adv = dm.advertisements
        hrf = dm.hrefs

        adv.each_with_index do |ad, index|
          Offer.create(:daily_mail => dm, :title => ad, :href => hrf[index])
        end
      end
    end
end