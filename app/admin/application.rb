ActiveAdmin.register Application do
  menu priority: 1000, id: 'Application'
  permit_params :name, :app_type, :secret

  show do
    attributes_table 'Application' do
      row :name
      row :app_type
      row 'App ID' do
        Digest::MD5.hexdigest(application.to_sgid.to_s)
      end
      row 'App Secret' do
        application.to_sgid
      end
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :app_type
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :app_type, collection: %w(full-access limited restrictive)
    end
    f.actions
  end
end