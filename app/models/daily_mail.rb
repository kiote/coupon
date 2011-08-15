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
    doc.xpath('/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td/div/a/strong/span').each do |a|
      adv << Sanitize.clean(a.to_html).strip
    end
    adv
  end

  def hrefs
    doc = Nokogiri::HTML self.message
    href = []
    doc.xpath('/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td/div/a').each do |a|
      href << a.attr("href")
    end
    href
  end
end
