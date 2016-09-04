require 'rest-client'
ActiveAdmin.register AzureRole do
  menu label: -> {t('admin.azure_role.menu')}
  permit_params :name, :azure_gid, :roles => []

  form do |f|
    f.inputs 'MARSU Permissions' do
      f.input :name
      f.input :roles, collection: %w(admin cowei permanencier tresorier), as: :check_boxes, multiple: true
    end
    def fetch_azure_groups
      r = RestClient.get("https://graph.microsoft.com/v1.0/groups", :Authorization => "Bearer #{current_user.azure_token}")
      JSON.parse(r.body)['value'].pluck 'displayName', 'id'
    rescue => _
      []
    end
    azure_groups = fetch_azure_groups
    if azure_groups.length > 0
      f.inputs 'Azure' do
        f.input :azure_gid, collection: azure_groups
      end
    else
      f.inputs 'Azure (Error)' do
        f.input :azure_gid, placeholder: t('admin.azure_role.could_not_fetch_enter_gid')
      end
    end
    f.actions
  end

end