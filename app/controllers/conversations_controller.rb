class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
  	if Conversation.between(params[:sender_id], params[:recipient_id]).present?
  		@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
  	else
  		@conversation = Conversation.create(params.permit(:sender_id,:recipient_id))
  	end

  	redirect_to conversation_messages_path(@conversation)
  end
end
