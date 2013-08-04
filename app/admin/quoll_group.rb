ActiveAdmin.register QuollGroup do
  menu priority: 3, parent: "Quoll"

  index do
    column :name
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.buttons
  end


  show do |g|
    attributes_table do
      row :name
    end
  end
end
