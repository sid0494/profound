class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@discussions = Array.new
  	temp_discussions = Array.new

  	current_user.expertise_areas.each do |area|
  		area.discussions.collect {|discussion| temp_discussions << discussion}
  	end

  	@discussions = temp_discussions.sort!{|discussion1, discussion2| discussion1.created_at <=> discussion2.created_at}.uniq

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

  		@tags.each do |tag|
  			@discussion.discussion_tags << Tag.find_by_name(tag)
  		end

  		if @discussion.save
  			redirect_to(:action => 'my_discussions')
  		else
  			print "Error in tags addition."
  		end
  	else
  		render('new')
  	end
  	
  end

  def show
  	@discussion = Discussion.find(params[:id])
  end

  def edit
  	@discussion = Discussion.find(params[:id])
  end

  def update
  	@discussion = Discussion.find(params[:id])
  	@discussion.update_attributes(params.require(:discussion).permit(:topic_name, :description))
  	params.permit(:tags => [])

  	if @discussion.save

  		@tags.each do |tag|
  			@discussion.discussion_tags << Tag.find_by_name(tag)
  		end

  		if @discussion.save
  			redirect_to(:action => 'my_discussions')
  		else
  			print "Error in tags addition."
  		end
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
  	redirect_to(:action => 'my_discussions')	
  end

  def my_discussions
  	@discussions = Discussion.where(owner_id: current_user.id).find_each  	
  end

end
