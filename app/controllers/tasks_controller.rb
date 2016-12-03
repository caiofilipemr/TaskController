class TasksController < ApplicationController
  before_action :verify_permission_and_set, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if 'Solicitante' == PROFILE_TYPE[current_user.profile_type].first
      @tasks = Task.where(user_created: current_user).all
    else
      @tasks = Task.all
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_created = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to edit_task_path(@task), notice: 'Tarefa criada com sucesso' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @follow_up = FollowUp.new(follow_ups_params)
    @follow_up.user = current_user
    task = Task.find(params[:id])
    task.attributes = task_params
    changes = task.changed
    str = String.new

    changes.each do |c|
      str << c
      str << ': '
      str << @task.send(c).to_s
      str << ' alterado para '
      str << task.send(c).to_s
      str << '\n'
    end
    @follow_up.updates = str

    @task.follow_ups << @follow_up unless not @follow_up.details or @follow_up.details.blank?
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to edit_task_path(@task), notice: 'Tarefa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Tarefa excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def verify_permission_and_set
    task = Task.find(params[:id])
    if 'Administrador' == PROFILE_TYPE[current_user.profile_type].first or task.user_created == current_user
      set_task(task)
      set_follow_ups if action_name == 'edit'
    else
      redirect_to tasks_url
    end
  end

  def set_task(task)
    @task = task
  end

  def set_follow_ups
    @follow_ups = @task.follow_ups
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :details, :priority, :user_attributed_id, :status,
                                 :stage, :init_date, :expected_completion_date, :code)
  end

  def follow_ups_params
    params.require(:follow_up).permit(:details)
  end
end
