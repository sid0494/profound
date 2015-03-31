class MessagingController < ApplicationController
  
  before_action :authenticate_user!

  def send_message
  	@message = Message.new
  end

  def save
  	@message = Message.new(params.require(:message).permit(:content))
  	params.permit(:username)
  	@message.sender_id = current_user.id
  	username = 

  	if not User.exists(username: params[:username])
  		render('send_message')
  	else
  		@message.sender = User.find_by_username(params[:username])
  		if @message.save
  			redirect_to("/")
  		else
  			render('send_message')
  		end
  	end
  end

  def show
  	@messages = Message.where(sender_id: current_user.id)
  end
end
