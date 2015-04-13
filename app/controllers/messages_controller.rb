class MessagesController < ApplicationController

	before_action :authenticate_user!
  	layout 'header_new'

  	def new
  		@message = @conversation.messages.new
  	end

  	def create
  		@message = Message.new
  		params.require(:message).permit(:body)
  		@message.body = params[:message][:body]
  		@message.user_id = current_user.id
  		params.permit(:recipient_id => [])
  		recipient_id = params[:recipient_id][0]

  		print recipient_id

  		if Conversation.between(current_user.id, recipient_id).present?
	  		conversation = Conversation.between(current_user.id,recipient_id).first
	  	else
	  		conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient_id)
	  	end

	  	@message.conversation_id = conversation.id


  		if @message.save
  			
  		else
  			print 'Error saving message'
  		end

  		redirect_to ('/')
  	end

  	def show_conversations
  		@conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  		@conversations = @conversations.sort { |c1, c2| c1.updated_at <=> c2.updated_at}.uniq.reverse
  	end

  	def show_messages
  		conversation = Conversation.find(params[:id])
  		if conversation.sender == current_user
  			@recipient = conversation.recipient
  		else
  			@recipient = conversation.sender
  		end
  		@messages = conversation.messages
  		@messages.each do |m|
  			if m.user_id != current_user.id
  				m.read = true
  				m.save
  			end
  		end
  	end
end
