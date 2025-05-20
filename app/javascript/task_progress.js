document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".task-card").forEach(card => {

    if (card.classList.contains("new-task-card")) return;
    
    card.addEventListener("click", () => {
      const taskId = card.dataset.taskId;
      const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
      fetch(`/tasks/${taskId}/task_logs`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Accept": "application/json"
        },
        body: JSON.stringify({ executed_on: today })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          const fill = card.querySelector(".fill");
          fill.style.background = `conic-gradient(${data.color_code} ${data.completion_rate}%, #ffffff ${data.completion_rate}%, #ffffff 100%)`;
        } else {
          alert("更新に失敗しました");
        }
      });
    });
  });
});
