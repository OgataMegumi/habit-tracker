class TaskLogsController < ApplicationController
    before_action :set_task

    def create
        @task.toggle_execution!(params[:executed_on])
        head :ok
    rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity    
    end

    private

    def set_task
        @task = Task.find(params[:task_id])
    end
end
