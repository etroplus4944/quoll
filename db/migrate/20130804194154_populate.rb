class Populate < ActiveRecord::Migration
  def up
    g1=QuollGroup.create(name:"First Group")
    g2=QuollGroup.create(name:"Second Group")
  end

  def down
  end
end
