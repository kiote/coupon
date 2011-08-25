module Groupon
  def self.included(base)
    base.extend ClassMethods
  end

  def advertisements
      doc = Nokogiri::HTML self.message
      adv = []
      href = []

      xpaths = [
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[1]/div[1]/a/strong/span',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[1]/table/tr/td[1]/a'
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/table[1]/tr/td[3]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[2]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[2]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[2]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[3]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[3]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[3]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[4]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[4]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[4]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[5]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[5]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[5]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[6]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[6]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[6]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[7]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[7]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[7]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[8]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[8]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[8]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[9]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[9]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[9]/a/strong/span/font',
        ],
        [
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[10]/a/strong/font',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[10]/a',
          'html/body/table[1]/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[10]/a/strong/span/font',
        ],
      ]

      xpaths.each do |elem|
        elem.each_with_index do |path, i|
          doc.xpath(path).each do |e|
            case i
              when 0,2
                s = Sanitize.clean(e.to_html).strip
                adv << s unless s==''
              when 1
                s = e.attr("href")
                href << s unless s==''
            end
          end
        end
      end

      [adv.uniq, href.uniq]
  end

  module ClassMethods
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
  end
end