ActiveAdmin.register QuollQuery do
  menu priority: 2, parent: "Quoll"

  index do
    column :name
    column :quoll_group
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description, :input_html => {  :rows => 2 }
      f.input :form, :input_html => {  :rows => 5 }
      f.input :report
      f.input :quoll_group
    end
    f.buttons
  end

  show do |g|
    attributes_table do
      row :name
      row :description
      row :form
      row :report
      row :quoll_group
    end
  end
end
