class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    # 進捗率が100%未満のタスク（進行中のタスク）
    @in_progress_tasks = Task.all.reject { |task| task.progress_percentage == 100 }

    # 進捗率が100%のタスク（完了したタスク）
    @completed_tasks = Task.all.select { |task| task.progress_percentage == 100 }

    @dates_in_month = Task.dates_in_current_month
    @progress_data = calculate_progress_data(@in_progress_tasks)
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

  def calculate_progress_data(tasks)
    progress_data = {}
    (Date.today - 9..Date.today).each do |date| # 過去10日間
      total_progress = tasks.sum do |task|
        if task.task_logs.exists?(executed_on: date)
          task.progress_percentage / 100.0 # 進捗率を割合に変換
        else
          0
        end
      end
      progress_data[date] = (total_progress * 100).round(1) # 再び%に戻す
    end
    progress_data
  end
end
