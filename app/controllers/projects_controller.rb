class ProjectsController < ApplicationController
  # before_action :set_project, only: %i[ show edit update destroy complete_and_archive reopen update_project_employees remove_project_employee ]
  before_action :set_project, only: %i[ show edit update destroy complete_and_archive reopen add_project_employees remove_project_employee ]
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
    @project_users = @project.users
    @organization_users = @project.organization.users
    @users_to_add = @organization_users - @project_users
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

  # # Update employee list for the project
  # def update_project_employees
  #   if params[:project][:user_ids]
  #     updated_user_ids = params[:project][:user_ids].reject(&:blank?).map(&:to_i)
  #     current_user_ids = @project.user_ids

  #     users_to_add = updated_user_ids - current_user_ids
  #     users_to_remove = current_user_ids - updated_user_ids
    
  #     users_to_add.each do |user_id|
  #       ProjectsUser.create(user_id: user_id, project: @project, organization: @project.organization)
  #     end
    
  #     users_to_remove.each do |user_id|
  #       # binding.irb
  #       ProjectsUser.where(user_id: user_id, project_id: @project.id, organization_id: @project.organization.id).delete_all
  #     end

  #     if @project.save
  #       redirect_to project_path(@project), notice: "Project employee list was successfully updated."
  #     else
  #       redirect_to project_path(@project), alert: "Failed to update project employee list."
  #     end
  #   else
  #     @project.users.delete_all
  #     redirect_to project_path(@project), alert: "All employees were removed from the project."
  #   end
  # end

  # Add employees to the project
  def add_project_employees
    users_to_add = params[:project][:user_ids].reject(&:blank?).map(&:to_i)
  
    users_to_add.each do |user_id|
      ProjectsUser.find_or_create_by(user_id: user_id, project: @project, organization: @project.organization)
    end
  
    if @project.save
      redirect_to project_path(@project), notice: "Employee/s were successfully added to the project."
    else
      redirect_to project_path(@project), alert: "Failed to add employee/s to the project."
    end
  end

  # Remove employees from the project
  def remove_project_employee
    user_id = params[:user_id]
    
    # binding.irb
    ProjectsUser.where(user_id: user_id, project_id: @project.id, organization_id: @project.organization.id).delete_all
    redirect_to project_path(@project), notice: "Employee was removed successfully."
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

