class TaskLogsController < ApplicationController
    before_action :set_task

    def create
        task = Task.find(params[:task_id])

        TaskLog.mark_as_done!(task, params[:executed_on])
        respond_to do |format|
            format.js
            format.html { redirect_to task_path(task) }
        end
    end
end
