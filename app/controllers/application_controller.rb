class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username,:first_name, :last_name,
      													:dob, :address, :city, :state, :country,
      													:profession, :institute, :degree, :contact,
      													:security_que, :security_ans, :learning_rp,
      													:discussion_rp, :project_rp,
      													:projects_worked_on, :ongoing_projects,
      													:email, :password, :password_confirmation) }
end
end
