require 'rest-client'
ActiveAdmin.register AzureRole do
  menu label: -> {t('admin.azure_role')}

  form do |f|
    def fetch_azure_groups
      r = RestClient.get("https://graph.microsoft.com/v1.0/groups", :Authorization => "Bearer #{current_user.azure_token}")
      JSON.parse(r.body)['value'].pluck 'displayName', 'id'
    rescue => _
      ['Unable to fetch groups from Azure, please logout and login again.']
    end
    f.inputs 'Azure' do
      f.input :azure_gid, collection: fetch_azure_groups
    end
    f.inputs 'MARSU Permissions' do
      f.input :name
      f.input :roles, collection: ['admin', 'permanencier', 'tresorier'], as: :check_boxes, multiple: true
    end
    f.actions
  end

end