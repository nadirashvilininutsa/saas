class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy complete_and_archive reopen ]
  before_action -> { has_required_permission?(:view_projects) }, only: [:index, :show]
  before_action -> { has_required_permission?(:manage_projects) }, only: [:new, :create]
  before_action -> { has_required_permission_and_is_author?(:manage_projects) }, only: [:edit, :complete_and_archive, :reopen, :update]

  # GET /projects or /projects.json
  def index
    @active_projects = Project.active.where(organization: current_user.organization)
    @archived_projects = Project.archived.where(organization: current_user.organization)
    @no_projects_present = @archived_projects.empty? && @active_projects.empty?
  end

  # GET /projects/1 or /projects/1.json
  def show
    @artifacts = @project.artifacts
    @tasks = @project.tasks
    @artifacts = @project.users
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # PATCH /projects/1 or /projects/1.json
  def complete_and_archive
    @project.update(completed: true, completion_date: Date.today)
    redirect_to projects_path, notice: 'Project has been completed and archived.'
  end

  # PATCH /projects/1 or /projects/1.json
  def reopen
    @project.update(completed: false)
    redirect_to projects_path, notice: 'Project has been reopened.'
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.organization = current_user.organization

    respond_to do |format|
      if @project.save
        ProjectsUser.create(user: current_user, project: @project, organization: current_user.organization)

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

  def has_required_permission?(permission)
    unless current_user.has_permission?(permission)
      redirect_to root_path, alert: "Access denied."
    end
  end
  
  def has_required_permission_and_is_author?(permission)
    unless current_user.has_permission?(permission) && @project.users.include?(current_user)
      redirect_to root_path, alert: "Access denied."
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :completion_date, :completed, :organization)
  end

  def free_plan?
    plan = Plan.find(current_user.organization.plan_id)
    plan.name.downcase == "free"
  end
  helper_method :free_plan? 
end

