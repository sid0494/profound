class DashboardController < ApplicationController
	before_action :authenticate_user!

	layout 'header'

  def home
  	@name = current_user.first_name
  	puts "#{@name} is shakal.."
  end
end
