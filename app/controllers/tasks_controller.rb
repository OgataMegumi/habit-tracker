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
    @progress_data = TaskLog.calculate_daily_progress(current_user)

    start_date = 13.days.ago.to_date
    end_date = Date.today
    date_range = (start_date..end_date).to_a

    @chart_data = date_range.map do |date|
      progress = @progress_data[date] || 0
      [date.strftime("%m/%d"), progress]
    end
  end

  def toggle_today
    task = Task.find(params[:id])
    TaskLog.toggle_for(task, Date.current)

    executed = task.task_logs.exists?(executed_on: Date.current)
    render json: {
      success: true,
      executed: executed,
      completion_rate: task.completion_rate,
      color_code: task.color_code
    }
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit_modal
    @task = Task.find(params[:id])
    Rails.logger.debug "task color: #{@task.color.inspect}"
    render partial: "form", locals: { task: @task }
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path }
        format.js
      else
        format.js
      end
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
