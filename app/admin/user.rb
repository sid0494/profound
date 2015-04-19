ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  config.clear_action_items!

  scope :reported_ones

  action_item :view, only: :show do
  link_to 'Delete User', admin_user_path(resource), data: {confirm: "Are you sure you want to delete ?"}, method: :delete
  end  

  action_item :view, only: :show do
  link_to 'Download Resume', dashboard_download_resume_path(id: resource.id) if not resource.resume_file_name.nil?
  end

  action_item :view, only: :show do
  link_to 'Download Verification Document', dashboard_download_verification_path(id: resource.id) if not resource.verification_file_name.nil?
  end

  action_item :view, only: :show do
  link_to 'Verify Account', dashboard_verification_path(id: resource.id) if resource.verified == false
  end


end
