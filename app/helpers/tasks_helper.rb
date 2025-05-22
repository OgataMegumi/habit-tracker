module TasksHelper
  def progress_circle_style(task)
    "background: conic-gradient(#{task.color_code} #{task.completion_rate}%, #ffffff #{task.completion_rate}%, #ffffff 100%)"
  end
end
