class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  # protect_from_forgery :except => :upvote 
  # protect_from_forgery :except => :downvote 

  layout 'header_new'

  def index
  	@discussions = Array.new
  	temp_discussions = Array.new

  	current_user.expertise_areas.each do |area|
  		area.discussions.collect {|discussion| temp_discussions << discussion}
  	end

    current_user.interest_areas.each do |area|
      area.discussions.collect {|discussion| temp_discussions << discussion}
    end

    current_user.followings.collect { |user| user.discussions.collect { |discussion| temp_discussions << discussion  } }

  	@discussions = temp_discussions.sort!{|discussion1, discussion2| discussion1.created_at <=> discussion2.created_at}.uniq.reverse.reverse

    # @discussions = Discussion.all.reverse

  end

  def new
  	@discussion = Discussion.new
  end

  def create
  	@discussion = Discussion.new(params.require(:discussion).permit(:topic_name, :description))
  	@discussion.owner_id = current_user.id
  	params.permit(:tags => [])
  	@tags = params[:tags]

  	if @discussion.save
      flash[:success] = "Discussion topic Created Successfully!"
      if not @tags.nil?
    		@tags.each do |tag|
    			temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @discussion.discussion_tags << Tag.find_by_tag_name(tag)            
          else
            @discussion.discussion_tags << Tag.create(tag_name: tag)
          end
    		end
      end
  		#if @discussion.save
  			redirect_to(:action => 'my_discussions')
  		#else
  		#	print "Error in tags addition."
  		#end
  	else
  		render('new')
  	end
  	
  end

  def show
  	@discussion = Discussion.find(params[:id])
    @discussion_reply = DiscussionReply.new
  end

  def edit
  	@discussion = Discussion.find(params[:id])
  end

  def update
  	@discussion = Discussion.find(params[:id])
  	@discussion.update_attributes(params.require(:discussion).permit(:topic_name, :description))
  	@discussion.discussion_tags.destroy_all
    params.permit(:tags => [])
    @tags = params[:tags]

  	if @discussion.save
      flash[:success] = "Discussion topic Updated Successfully!"

      if not @tags.nil?
  		  @tags.each do |tag|
    			temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @discussion.discussion_tags << Tag.find_by_tag_name(tag) if not @discussion.discussion_tags.include?(temp_tag)            
          else
            @discussion.discussion_tags << Tag.create(tag_name: tag)
          end
    		end
      end

  		#if @discussion.save
  			redirect_to(:action => 'my_discussions')
  		# else
  		# 	print "Error in tags addition."
  		# end
  	else
  		render('edit')
  	end
  end

  def delete
  	@discussion = Discussion.find(params[:id])  	
  end

  def destroy
  	@discussion = Discussion.find(params[:id])
  	@discussion.destroy
    flash[:danger] = "Discussion topic Deleted Successfully!"
  	redirect_to(:action => 'my_discussions')	
  end

  def my_discussions
  	@discussions = current_user.discussions.reverse	
  end

  def reply
    @discussion_reply = DiscussionReply.new(params.require(:discussion_reply).permit(:reply))
    @discussion_reply.user = current_user

    if @discussion_reply.save
      flash[:success] = "Replied Successfully to the Discussion Topic!"
      params.require(:discussion_reply).permit(:id)
      @discussion = Discussion.find(params[:discussion_reply][:id])
      @discussion.discussion_replies << @discussion_reply
      Notification.create(type: "discussion_reply", type_id: @discussion.id, optional_id: @discussion_reply.user_id, user_id: @discussion.owner_id)
      redirect_to(:action =>'show',:id => @discussion.id)
    else
      flash[:danger] = "Error Posting Reply!"
      print "Error posting reply"
    end
  end

  def upvote
    @discussion_reply = DiscussionReply.find(params[:id])
    @discussion_reply.upvotes += 1
    @user = User.find(@discussion_reply.user_id)
    @user.discussion_rp += 1
    @user.save
    @discussion_reply.voters << current_user

    if @discussion_reply.save
      respond_to do |format|
        format.js
      end
    end
  end

  def downvote
    @discussion_reply = DiscussionReply.find(params[:id])
    @discussion_reply.downvotes += 1
    @user = User.find(@discussion_reply.user_id)
    @user.discussion_rp -= 1
    @user.save    
    @discussion_reply.voters << current_user

    if @discussion_reply.save
      respond_to do |format|
        format.js
      end
    end
  end

end
