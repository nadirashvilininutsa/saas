class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy complete_and_archive reopen ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
    @active_projects = Project.active
    @archived_projects = Project.archived

    @current_user = current_user
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def complete_and_archive
    @project.update(completed: true, completion_date: Date.today)
    redirect_to projects_path, notice: 'Project has been completed and archived.'
  end

  def reopen
    @project.update(completed: false)
    redirect_to projects_path, notice: 'Project has been reopened.'
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.organization = current_user.organization
    @project.users << current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        @project.users.delete(current_user)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :completion_date, :completed)
    end
end