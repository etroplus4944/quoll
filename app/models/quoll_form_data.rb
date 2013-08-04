# == Schema Information
#
# Table name: form_data
#
#  id         :integer          not null, primary key
#  query_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  int1       :integer
#  int2       :integer
#  int3       :integer
#  int4       :integer
#  int5       :integer
#  int6       :integer
#  int7       :integer
#  int8       :integer
#  int9       :integer
#  string1    :string(255)
#  string2    :string(255)
#  string3    :string(255)
#  string4    :string(255)
#  string5    :string(255)
#  string6    :string(255)
#  string7    :string(255)
#  string8    :string(255)
#  string9    :string(255)
#  name       :string(255)
#  date1      :date
#  date2      :date
#  date3      :date
#  date4      :date
#  date5      :date
#  date6      :date
#  date7      :date
#  date8      :date
#  date9      :date
#

class QuollFormData < ActiveRecord::Base
  belongs_to :quoll_query
  attr_accessible  :quoll_query_id, :query, :name, :int1, :int2, :int3, :int4, :int5, :int6, :int7, :int8,
                   :int9,:string1,:string2,:string3,:string4,:string5,:string6,:string7,:string8,
                   :string9, :date1, :date2,:date3,:date4,:date5,:date6,:date7,:date8,:date9

end
