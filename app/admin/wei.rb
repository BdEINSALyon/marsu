ActiveAdmin.register Wei do
  menu priority: 4, id: 'Wei'
  permit_params :name, :price, :date, :seats, :enabled

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :date
      f.input :seats
      f.input :enabled, as: :boolean
    end
    f.actions
  end
end