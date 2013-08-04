class ForQuoll < ActiveRecord::Migration
  def change
        create_table :quoll_queries do |t|
          t.string :name
          t.string :description
          t.text :form
          t.text :report
          t.integer :order
          t.integer :quoll_group_id
        end
        create_table :quoll_groups do |t|
              t.string :name
        end
        create_table :quoll_form_data do |t|
          t.integer :quoll_query_id
          t.integer :int1
          t.integer :int2
          t.integer :int3
          t.integer :int4
          t.integer :int5
          t.integer :int6
          t.integer :int7
          t.integer :int8
          t.integer :int9
          t.integer :string1
          t.integer :string2
          t.integer :string3
          t.integer :string4
          t.integer :string5
          t.integer :string6
          t.integer :string7
          t.integer :string8
          t.integer :string9
          t.string :name
          t.date :date1
          t.date :date2
          t.date :date3
          t.date :date4
          t.date :date5
          t.date :date6
          t.date :date7
          t.date :date8
          t.date :date9
        end
  end
end
