class ProjectsController < ApplicationController

  before_action :authenticate_user!
  layout 'header_new'
  
  def index
    @projects = Array.new
    @search_objects = Array.new
    temp_projects = Array.new

    Project.all.collect { |project| @search_objects << {name: project.project_name, id: project.id.to_s + ":p", token: "Project"} }
    User.all.collect { |user| @search_objects << {name: user.username, id: user.id.to_s + ":u", token: "User"}  }
    Tag.all.collect { |tag| @search_objects << {name: tag.tag_name, id: tag.id.to_s + ":t", token: "Tag"}  }


    #Create array of all the projects that have the tags of the user's expertise area
    current_user.expertise_areas.each do |area|
      area.projects.collect {|project| temp_projects << project}
      # print "~~~~~~~~~~"
    end

    # current_user.interest_areas.each do |area|
    #   area.projects.collect {|project| temp_projects << project}
    # end

    current_user.followings.collect { |user| user.projects.collect { |project| temp_projects << project }  }

    print temp_projects

    #Select the latest 10 projects to display
    @projects = temp_projects.sort! {|project_1, project_2| project_1.created_at <=> project_2.created_at}.uniq.reverse

    # @projects = Project.all.reverse

  end

  def show
    @project = Project.find(params[:id])
    @message = Message.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:project_name, :project_description, :project_status))
    params.permit(:tags => [])
    @tags = params[:tags]
    #print @tags
    @project.user_id = current_user.id

    #Try to save the newly created project
    if @project.save
      flash[:success] = "Project Created Successfully!"
      #Add tags for the project
      if not @tags.nil?
        @tags.each do |tag|
          temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @project.project_tags << Tag.find_by_tag_name(tag)            
          else
            @project.project_tags << Tag.create(tag_name: tag)
          end
        end
      end
      #If successful then display My Projects Page
      redirect_to(:action => 'my_projects')

    else
      #If fails then ask to fill the form again
      render('new')
    end
  end

  def edit
    @project = Project.find(params[:id])
    print "Hi there #{@project.project_name} and #{params[:id]}"
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params.require(:project).permit(:id, :project_name, :project_description, :project_status))
    @project.project_tags.destroy_all
    params.permit(:tags => [])
    @tags = params[:tags]

    #Try to save the newly update project
    if @project.save
      flash[:success] = "Project Updated Successfully!"
      if not @tags.nil?
        @tags.each do |tag|
          temp_tag = Tag.find_by_tag_name(tag)
          if not temp_tag.nil?
            @project.project_tags << Tag.find_by_tag_name(tag) if not @project.project_tags.include?(temp_tag)            
          else
            @project.project_tags << Tag.create(tag_name: tag)
          end
        end
      end
      #If successful then display My Projects Page
      redirect_to(:action => 'my_projects')
    else
      #If fails then ask to fill the form again
      render('edit')
    end

  end

  def delete
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:danger] = "Project Deleted Successfully!"
    redirect_to(:action => 'my_projects')
  end

  def my_projects
    #Create array of all the projects created by the current user
    @projects = current_user.projects.sort {|project_1, project_2| project_1.created_at <=> project_2.created_at}.reverse
  end

  def share
    project = Project.find(params[:id])
    current_user.shared_projects << project
    current_user.followers.each do |user|
      Notification.create(type: "share", type_id: project.id, optional_id: current_user.id, user_id: user.id)
    end
    flash[:info] = "Project Shared Successfully!"
    redirect_to('/projects/my_projects')
  end

  def commend
    @user = User.find(params[:id])
    @user.project_rp += 1
    @user.save

    commendation = Commendation.new
    commendation.user = current_user
    commendation.commended_user_id = @user.id
    commendation.entity_id = params[:id_2]
    commendation.entity = "project"
    commendation.save
    flash[:success] = "User Commended Successfully!"
    redirect_to(:action => 'index')
  end

  def search
    @search_objects = Array.new
    str = params[:search][0]
    id = str.split(":")[0].to_i
    token = str.split(":")[1]
    print token

    Project.all.collect { |project| @search_objects << {name: project.project_name, id: project.id.to_s + ":p", token: "Project"} }
    User.all.collect { |user| @search_objects << {name: user.username, id: user.id.to_s + ":u", token: "User"}  }
    Tag.all.collect { |tag| @search_objects << {name: tag.tag_name, id: tag.id.to_s + ":t", token: "Tag"}  }
    
    if token == "t"
      @projects = Tag.find(id).projects
    elsif token == "u"
      @projects = User.find(id).projects
    else
      @projects = []
      @projects << Project.find(id)
    end

    render("index")
  end
end
