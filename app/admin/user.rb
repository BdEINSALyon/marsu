ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role_ids

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :roles

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs 'Roles' do
      f.input :roles, as: :check_boxes
    end
    f.actions
  end

  controller do
    def create
      @user = User.new(permitted_params[:user])
      add_roles(@user)
      create!
    end

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      add_roles(resource)
      update!
    end

    private
    def add_roles(resource)
      resource.roles = []
      params[:user][:role_ids].each { |r| resource.roles.push(Role.find(r)) unless r.blank? }
    end
  end

end
