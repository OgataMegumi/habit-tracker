class TaskLogsController < ApplicationController
  before_action :set_task

  def create
    TaskLog.mark_as_done!(@task, params[:executed_on])
    respond_to do |format|
        format.html { redirect_to task_path(@task) }
        format.json {
          render json: {
            success: true,
            completion_rate: @task.completion_rate,
            color_code: @task.color_code
          }
        }
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
