class ArtifactsController < ApplicationController
  before_action -> { has_permission?(:view_artifacts) }, only: [:show]
  before_action :set_project
  before_action :set_artifact, only: %i[show update destroy]
  before_action -> { has_permission_and_is_author?(:manage_artifacts) }, only: [:create, :update, :destroy]


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
    if @artifact.save
      redirect_to @project, notice: 'Artifact was successfully uploaded.'
    else
      render :show
    end
  end

  # def edit
  # end

  def update
    if @artifact.update(artifact_params)
      redirect_to @project, notice: 'Artifact was successfully uploaded.'
    else
      render :show
    end
  end

  def destroy
    # binding.irb
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

  def has_permission_and_is_author?(permission)
    unless has_permission?(permission) && @artifact.user == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end
end
