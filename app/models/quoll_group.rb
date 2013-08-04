# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuollGroup < ActiveRecord::Base
  has_many :quoll_queries
  attr_accessible :name
end
