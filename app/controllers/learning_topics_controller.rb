class LearningTopicsController < ApplicationController
  before_action :authenticate_user!

  layout 'header'
  
  def index
    @topics = Array.new
    temp_topics = Array.new

    current_user.expertise_areas.each do |area|
      area.collect {|topic| temp_topics << topic }
    end

    @topics = temp_topics.sort!{|topic1, topic2| topic1.created_at <=> topic2.created_at}.uniq

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

      @tags.each do |tag|
        @topic.learning_tags << Tag.find_by_name(tag)
      end

      if @topic.save
        redirect_to(:action => 'my_topics')
      else
        print "Error in tags addition."
      end
    else
      render('new')
    end
    
  end

  def show
    @topic = Discussion.find(params[:id])
  end

  def edit
    @topic = LearningTopic.find(params[:id])
  end

  def update
    @topic = Discussion.find(params[:id])
    @topic.update_attributes(params.require(:learning_topic).permit(:topic_name, :description))
    params.permit(:tags => [])

    if @topic.save

      @tags.each do |tag|
        @topic.learning_tags << Tag.find_by_name(tag)
      end

      if @topic.save
        redirect_to(:action => 'my_topics')
      else
        print "Error in tags addition."
      end
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
    @topics = LearningTopic.where(owner_id: current_user.id).find_each
  end
end
