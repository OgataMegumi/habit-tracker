import { withLoading } from "task_toggle_helper";

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".task-card").forEach(card => {
    if (card.classList.contains("new-task-card")) return;

    card.addEventListener("click", (event) => {
      if (
        event.target.closest(".edit-task-btn") ||
        event.target.closest(".dropdown-item")
      ) {
        return;
      }
      
      const taskId = card.dataset.taskId;
      if (!taskId) return;

      const today = new Date().toISOString().split('T')[0];

      withLoading(card, () => {
        return fetch(`/tasks/${taskId}/toggle_today`, {
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
          // 取り消し線の切り替え処理
          const titleEl = card.querySelector(".task-title");
          if (data.executed) {
            titleEl.classList.add("executed");
          } else {
            titleEl.classList.remove("executed");
          }

          // 進捗グラフ更新処理
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
});
