require "gmail"

@gmail = Gmail.new('groupon.receiver@gmail.com', 'OoX$,QG@Nr^5{,*J')

namespace :mail do
    desc 'receive email'
    task :receive => :environment do
      @gmail.inbox.emails(:unread, :from => "daily@e.groupon.ru").each do |email|
        body = email.body
        str = body.parts[1].decoded
        str.force_encoding('iso-8859-5')
        Groupon.create(:message => str.encode('utf-8'))
      end
    end
end

