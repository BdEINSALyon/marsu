ActiveAdmin.register Payment do

  menu id: 'Payment', priority: 3
  permit_params :payment_method_id, :refunded

  index do
    selectable_column
    id_column
    column :payable
    column :student
    column :payment_method
    column :refunded
    actions
  end

  form do |f|
    f.inputs 'Payment' do
      f.input :payable, collection: [f.object.payable],  :input_html => { :disabled => true }
      f.input :student, collection: [f.object.student], :input_html => { :disabled => true }
      f.input :payment_method
      f.input :refunded
    end
    f.actions
  end

end