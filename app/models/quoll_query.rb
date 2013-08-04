# == Schema Information
#
# Table name: queries
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  form             :text
#  report           :text
#  required_ability :text
#  order            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  group_id         :integer
#

class QuollQuery < ActiveRecord::Base
  belongs_to :quoll_group
  has_many :quoll_form_data

  validates :quoll_group, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :report, presence: true

  attr_accessible :description, :form, :name, :order, :report, :required_ability, :quoll_group_id
end
