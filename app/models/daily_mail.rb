# == Schema Information
#
# Table name: groupons
#
#  id         :integer         not null, primary key
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'nokogiri'

class DailyMail < ActiveRecord::Base
  has_many :offers

  def advertisements
    doc = Nokogiri::HTML self.message
    adv = []

    xpaths = ['/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td/div/a/strong/span',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[2]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[3]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[4]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[5]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[6]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[7]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[8]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[9]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[10]/a/strong/font',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[11]/a/strong/font',
    ]

    xpaths.each do |path|
      doc.xpath(path).each do |a|
        adv << Sanitize.clean(a.to_html).strip
      end
    end

    adv.uniq
  end

  def hrefs
    doc = Nokogiri::HTML self.message
    href = []
    xpaths = ['/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td/div/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/table/tr/td[3]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[2]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[3]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[4]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[5]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[6]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[7]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[8]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[9]/a',
      '/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td[2]/div[10]/a'
    ]

    xpaths.each do |path|
      doc.xpath(path).each do |a|
        href << a.attr("href")
      end
    end
    href.uniq
  end
end
