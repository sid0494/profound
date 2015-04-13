class LearningTopicsController < ApplicationController
  before_action :authenticate_user!

  layout 'header_new'
  
  def index
    @topics = Array.new
    temp_topics = Array.new

    current_user.interest_areas.each do |area|
      area.learning_topics.collect {|topic| temp_topics << topic }
    end

    @topics = temp_topics.sort!{|topic1, topic2| topic1.created_at <=> topic2.created_at}.uniq.reverse
    # @topics = LearningTopic.all

  end

  def show
    @topic = LearningTopic.find(params[:id])
  end

  def new
    @topic = LearningTopic.new
  end

  def create
    @topic = LearningTopic.new(params.require(:learning_topic).permit(:topic_name, :description))
    @topic.owner_id = current_user.id
    params.permit(:tags => [])
    @tags = params[:tags]

    if @topic.save

      if not @tags.nil?
        @tags.each do |tag|
         temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @topic.learning_tags << Tag.find_by_tag_name(tag) if not @topic.learning_tags.include?(temp_tag)           
          else
            @topic.learning_tags << Tag.create(tag_name: tag)
          end
        end
      end

     # if @topic.save
        redirect_to(:action => 'my_topics')
      # else
      #   print "Error in tags addition."
      # end
    else
      render('new')
    end
    
  end

  def edit
    @topic = LearningTopic.find(params[:id])
  end

  def update
    @topic = LearningTopic.find(params[:id])
    @topic.update_attributes(params.require(:learning_topic).permit(:topic_name, :description))
    params.permit(:tags => [])
    @tags = params[:tags]

    if @topic.save

      if not @tags.nil?
        @tags.each do |tag|
          temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @topic.learning_tags << Tag.find_by_tag_name(tag)            
          else
            @topic.learning_tags << Tag.create(tag_name: tag)
          end
        end
      end 
      # if @topic.save
        redirect_to(:action => 'my_topics')
      # else
      #   print "Error in tags addition."
      # end
    else
      render('edit')
    end
    
  end

  def delete
    @topic = LearningTopic.find(params[:id])
  end

  def destroy
    @topic = LearningTopic.find(params[:id])
    @topic.destroy
    redirect_to(:action => 'my_topics')
  end

  def my_topics
    @topics = current_user.learning_topics
  end

  def commend
    @user = User.find(params[:id])
    @user.learning_rp += 1
    @user.save

    redirect_to(:action => 'index')
  end
end
