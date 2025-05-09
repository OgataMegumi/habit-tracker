class TaskLogsController < ApplicationController
    before_action :set_task

    def create
        @task.toggle_execution!(params[:executed_on])
        respond_to do |format|
            format.js
            format.html { redirect_to task_path(@task) }
        end
    end

    private

    def set_task
        @task = Task.find(params[:task_id])
    end
end
