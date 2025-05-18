class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    keyword = params[:q].presence&.strip

    @in_progress_tasks = Task.in_progress_for(current_user, keyword)
    @completed_tasks   = Task.completed_for(current_user, keyword)

    @tasks = current_user.tasks.includes(:task_logs)
    @random_message = current_user.tasks.pluck(:message).sample
    @current_month_dates = Task.dates_in_current_month
    @progress_data = TaskLog.calculate_daily_progress
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :category, :frequency, :message, :start_date, :end_date, :color, :frequency_number, :frequency_unit)
  end
end
