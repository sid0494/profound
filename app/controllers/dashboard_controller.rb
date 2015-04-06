class DashboardController < ApplicationController
	before_action :authenticate_user!

	layout 'header_new'

  def home
  	@name = current_user.first_name
  	@rp = (10 * current_user.learning_rp + 10 * current_user.discussion_rp + 10 * current_user.project_rp).to_i
  	@my_projects = current_user.projects
  	@my_discussions = current_user.discussions
  end

  def show_profile
    @user = User.find(params[:id])
    @rp = ((@user.learning_rp + @user.project_rp + @user.discussion_rp) * 10).to_i
  end

  def search
  	@user = User.find_by_username(params[:username])
  	render ('show_profile')
  end

  def about_us
  end

  def contact_us
  end
end
