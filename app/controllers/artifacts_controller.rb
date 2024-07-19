class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :update, :destroy]

  def index
    @artifacts = Artifact.all
  end

  def show
  end

  def new
    binding.irb
    @project_id = params[:project_id]
    @artifact = Artifact.new
  end

  def create
    @artifact = Artifact.new(artifact_params)
    @artifact.project_id = params[:artifact][:project_id]

    binding.irb

    if @artifact.save
      redirect_to @artifact, notice: 'Artifact was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @artifact.update(artifact_params)
      redirect_to @artifact, notice: 'Artifact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @artifact.destroy
    redirect_to artifacts_url, notice: 'Artifact was successfully destroyed.'
  end

  private

  def set_artifact
    @artifact = Artifact.find(params[:id])
  end

  def artifact_params
    params.require(:artifact).permit(:name, :file, :project_id)
  end
end
