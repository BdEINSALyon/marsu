ActiveAdmin.register Membership do
  permit_params :name, :price, :start_date, :end_date

  form do |f|
    f.inputs 'Membership' do
      f.input :name
      f.input :price
      f.input :start_date
      f.input :end_date
    end
    f.actions
  end
end