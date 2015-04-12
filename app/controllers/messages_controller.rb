class MessagesController < ApplicationController

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

  		if Conversation.between(current_user.id, params[:user_id]).present?
	  		conversation = Conversation.between(current_user.id,recipient_id).first
	  	else
	  		conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient_id)
	  	end

	  	@message.conversation_id = conversation.id


  		if @message.save
  			redirect_to ('/')
  		else
  			print 'Error saving message'
  		end
  	end
end
