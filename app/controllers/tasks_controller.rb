class TasksController < ApplicationController
  before_action :set_task, only: [ :complete, :reopen ]
  before_action :set_project, only: [ :create, :complete, :reopen ]

  before_action -> { has_required_permission?(:manage_tasks) }, only: [:create, :complete, :reopen]


  # # GET /tasks or /tasks.json
  # def index
  #   @tasks = @project.tasks.all
  # end

  # # GET /tasks/1 or /tasks/1.json
  # def show
  # end

  # # GET /tasks/new
  # def new
  #   @task = Task.new
  # end

  # # GET /tasks/1/edit
  # def edit
  # end

  # POST /tasks or /tasks.json
  def create
    # binding.irb
    @task = Task.new(task_params)
    @task.user = current_user
    @task.project = @project
    @task.organization = current_user.organization

    respond_to do |format|
      if @task.save
        redirect_to @project, notice: "Task was successfully created."
      else
        redirect_to @project, notice: "There was an error - task could not be created."
      end
    end
  end

  # # PATCH/PUT /tasks/1 or /tasks/1.json
  # def update
  #   respond_to do |format|
  #     if @task.update(task_params)
  #       format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
  #       format.json { render :show, status: :ok, location: @task }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @task.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /tasks/1 or /tasks/1.json
  # def destroy
  #   @task.destroy!
  #   redirect_to @project, notice: 'Task was successfully destroyed.'
  # end

  def complete
    @task.update(completed: true, completion_date: Date.today)
    redirect_to @project, notice: 'Task has been completed.'
  end

  def reopen
    @task.update(completed: false, completion_date: nil)
    redirect_to @project, notice: 'Task has been reopened.'
  end

  private
    
    def has_required_permission?(permission)
      unless current_user.has_permission?(permission)
        redirect_to root_path, alert: "Access denied."
      end
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed, :completion_date, :project, :user, :organization)
    end
end
