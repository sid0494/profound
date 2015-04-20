class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  layout :resolve_layout

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super

    if resource.save
      params.permit(:tags_interest_areas => [])
      @interest_tags = params[:tags_interest_areas]

      resource.interest_areas.destroy_all

      if not @interest_tags.nil?
        @interest_tags.each do |tag|
          temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            resource.interest_areas << temp_tag if not resource.interest_areas.include?(temp_tag)           
          else
            resource.interest_areas << Tag.create(tag_name: tag)
          end
        end
      end

      params.permit(:tags_expertise_areas => [])
      @expertise_tags = params[:tags_expertise_areas]

      resource.expertise_areas.destroy_all

      if not @expertise_tags.nil?
        @expertise_tags.each do |tag|
          temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            resource.expertise_areas << Tag.find_by_tag_name(tag) if not resource.expertise_areas.include?(temp_tag)           
          else
            resource.expertise_areas << Tag.create(tag_name: tag)
          end
        end
      end
    end
  end

  # DELETE /resource
  def destroy
    super

    notifications = Notification.where("(notifications.type = ? AND notifications.type_id = ?)
                                        OR (notifications.type != ? AND notifications.type_id = ?)", "follow", resource.id, "follow", resource.id)

    notifications.destroy_all
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def resolve_layout
    case action_name
    when 'new','create'
      'login_header'
    else
      'header_new'
    end
  end
end
