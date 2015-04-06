class ProjectsController < ApplicationController

  before_action :authenticate_user!
  layout 'header_new'
  
  def index
    @projects = Array.new
    temp_projects = Array.new

    #Create array of all the projects that have the tags of the user's expertise area
    current_user.expertise_areas.each do |area|
      area.projects[0..9].collect {|project| temp_projects << project}
    end

    #Select the latest 10 projects to display
    @projects = temp_projects.sort! {|project_1, project_2| project_1.created_at <=> project_2.created_at}.uniq[0..9]

    @projects = Project.all

  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:project_name, :project_description, :project_status))
    # params.permit(:tags => [])
    # @tags = params[:tags]
    #print @tags
    @project.user_id = current_user.id

    #Try to save the newly created project
    if @project.save
      #Add tags for the project
      # @tags.each do |tag|
      #   @project.project_tags << Tag.find_by_tag_name(tag)
      # end
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

    #Try to save the newly update project
    if @project.save
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
    redirect_to(:action => 'my_projects')
  end

  def my_projects
    #Create array of all the projects created by the current user
    @projects = current_user.projects
  end

  def commend
    @user = User.find(params[:id])
    @user.project_rp += 1
    @user.save

    redirect_to(:action => 'index')
  end
end
