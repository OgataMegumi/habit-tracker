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
          // 実行済みアイコン表示
          const titleIconEl = card.querySelector(".executed-icon");
          if (data.executed) {
            titleIconEl.style.display = "inline-block";
          } else {
            titleIconEl.style.display = "none";
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
