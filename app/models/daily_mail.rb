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

  include ::Groupon

end
