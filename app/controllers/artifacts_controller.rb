class ArtifactsController < ApplicationController
  before_action -> { has_required_permission?(:view_artifacts) }, only: [:show]
  before_action :set_project
  before_action :set_artifact, only: [:show, :destroy]
  before_action -> { has_required_permission_and_access_to_project?(:manage_artifacts) }, only: [:create]
  before_action -> { has_required_permission_and_is_author?(:manage_artifacts) }, only: [:destroy]


  # def index
  #   @artifacts = @project.artifacts
  # end

  def show
  end

  # def new
  #   @project_id = params[:project_id]
  #   @artifact = Artifact.new
  # end

  def create
    @artifact = @project.artifacts.build(artifact_params)
    @artifact.user = current_user
    @artifact.organization = current_user.organization

    if @artifact.save
      redirect_to @project, notice: 'Artifact was successfully uploaded.'
    else
      render :show
    end
  end

  # def edit
  # end

  # def update
  #   if @artifact.update(artifact_params)
  #     redirect_to @project, notice: 'Artifact was successfully uploaded.'
  #   else
  #     render :show
  #   end
  # end

  def destroy
    @artifact.destroy
    redirect_to @project, notice: 'Artifact was successfully destroyed.'
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_artifact
    @artifact = @project.artifacts.find(params[:id])
  end
  
  def artifact_params
    params.require(:artifact).permit(:name, :file)
  end

  def has_required_permission?(permission)
    unless current_user.has_permission?(permission)
      redirect_to root_path, alert: "Access denied."
    end
  end

  def has_required_permission_and_access_to_project?(permission)
    unless current_user.has_permission?(permission) && @project.users.include?(current_user)
      redirect_to root_path, alert: "Access denied."
    end
  end

  def has_required_permission_and_is_author?(permission)
    unless current_user.has_permission?(permission) && @project.users.include?(current_user) && @artifact.user == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end
end
