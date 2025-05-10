class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all

    @in_progress_tasks = Task.all.reject { |task| task.completion_rate == 100 }

    @completed_tasks = Task.all.select { |task| task.completion_rate == 100 }

    @done_tasks = Task.includes(:task_logs)

    @dates_in_month = Task.dates_in_current_month
    @progress_data = TaskProgressCalculator.new(@done_tasks).call
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
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
