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

class Groupon < ActiveRecord::Base
  def advertisement
    doc = Nokogiri::HTML self.message
    doc.xpath('/html/body/table/tr[2]/td/div/table/tr[2]/td[2]/table/tr[2]/td/table/tr/td/div/a/strong/span').each do |a|
      p Sanitize.clean(a.to_html).strip
    end
  end
end

