class DashboardController < ApplicationController
	before_action :authenticate_user!

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

  def upload
	uploaded_io = params[:person][:picture]
	File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
		file.write(uploaded_io.read)
	end
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
