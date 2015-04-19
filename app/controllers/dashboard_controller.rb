class DashboardController < ApplicationController
	before_action :authenticate_user!
	skip_before_filter :authenticate_user!, :only => [:download_verification, :download_resume, :verification]

	layout 'header_new'

  def home
  	@name = current_user.first_name
  	@rp = (10 * current_user.learning_rp + 10 * current_user.discussion_rp + 10 * current_user.project_rp).to_i
  	@my_projects = current_user.projects
  	@my_discussions = current_user.discussions
    @my_topics = current_user.learning_topics
    @message_count = 0
    conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    conversations.each do |conversation|
    	conversation.messages.collect { |m| @message_count += 1 if m.user_id != current_user.id and m.read == false }
    end
  	@message = Message.new
  end

  def show_profile
  	@message = Message.new
    @user = User.find(params[:id])
    @rp = ((@user.learning_rp + @user.project_rp + @user.discussion_rp) * 10).to_i
  end

  def search
  	redirect_to(:action => 'show_profile', :id => params[:search][0])
  end

  def follow
  	user = User.find(params[:id])
  	current_user.followings << user
  	Notification.create(type: "follow", type_id: current_user.id, user_id: user.id,read: false)
  	redirect_to('/')
  end

  def unfollow
  	user = User.find(params[:id])
  	current_user.followings.delete(user)
  	redirect_to('/')
  end

  def followers
  	@users = current_user.followers
  	@page_name = "Followers"
  	render('follow')
  end

  def followings
  	@users = current_user.followings
  	@page_name = "Followings"
  	render('follow')
  end

  def show_notifications
  	@notifications = current_user.notifications
  end

  def download_resume
  	user = User.find(params[:id])
  	file_path = user.resume_file_name
  	if not file_path.nil?
  		send_file "#{Rails.root}/public/system/users/resumes/000/000/#{format("%03d", user.id)}/original/#{file_path}", :x_sendfile => true
  	else
  		flash[:notice] = "File not found"
  		redirect_to (dashboard_show_profile_path(id: user.id))
  	end
  end

  def download_verification
  	user = User.find(params[:id])
  	file_path = user.verification_file_name
  	if not file_path.nil?
  		send_file "#{Rails.root}/public/system/users/verifications/000/000/#{format("%03d", user.id)}/original/#{file_path}", :x_sendfile => true
  	else
  		flash[:notice] = "File not found"
  		redirect_to (dashboard_show_profile_path(id: user.id))
  	end
  end

  def report
  	@report = Report.new
  	@user = User.find(params[:id])
  end

  def report_submit
  	@report = Report.new(params.require(:report).permit(:description, :reported_id))
  	@report.reporter_id = current_user.id

  	if @report.save
  		redirect_to (dashboard_show_profile_path(id: @report.reported_id))
  	end
  end

  def verification
  	@user = User.find(params[:id])
  	@user.verified = true
  	@user.save
  	redirect_to :back
  end

  def about_us
  end

  def contact_us
  end

  def help
  end

  def faqs
  end
end
