class TaskLogsController < ApplicationController
    before_action :set_task

    def create
        @task.task_logs.create!(executed_on: Date.parse(params[:executed_on]))
        head :ok
    end

    def destroy
        @task.task_logs.where(executed_on: Date.parse(params[:executed_on])).destroy_all
        head :ok
    end

    private

    def set_task
        @task = Task.find(params[:task_id])
    end
end
