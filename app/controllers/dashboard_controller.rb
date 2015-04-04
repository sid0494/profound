class DashboardController < ApplicationController
	before_action :authenticate_user!

	layout 'header_new'

  def home
  	@name = current_user.first_name
  	puts "#{@name} is shakal.."
  end

  def about_us
  end

  def contact_us
  end

end
