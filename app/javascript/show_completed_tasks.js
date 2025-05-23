document.addEventListener('DOMContentLoaded', () => {
  const toggleBtn = document.getElementById('toggle-completed-tasks-btn');
  const taskList = document.getElementById('completed-task-list');
  if (!taskList || !toggleBtn) return;

  const originalDisplay = taskList.dataset.originalDisplay || "grid";

  toggleBtn.addEventListener('click', () => {
    const isCurrentlyVisible = getComputedStyle(taskList).display !== 'none';
    const shouldShow = !isCurrentlyVisible;

    taskList.style.display = shouldShow ? originalDisplay : 'none';

    toggleBtn.innerHTML = shouldShow
      ? '<i class="fa-solid fa-toggle-on fa-lg" style="color: #afafaf;"></i>'
      : '<i class="fa-solid fa-toggle-off fa-lg" style="color: #afafaf;"></i>';

    fetch('/user/toggle_completed_tasks', {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ show_completed_tasks: shouldShow })
    });
  });
});
