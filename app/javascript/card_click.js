document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".task-card").forEach(card => {
    card.addEventListener("click", () => {
      const url = card.dataset.url;
      if (url) {
        window.location.href = url;
      }

      const taskId = card.dataset.taskId;
      const titleEl = card.querySelector(".task-title");

      fetch(`/tasks/${taskId}/toggle_today`, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Content-Type": "application/json",
        },
      })
        .then((res) => {
          if (!res.ok) throw new Error("Failed to toggle task");
          return res.json();
        })
        .then((data) => {
          if (data.completed_today) {
            titleEl.classList.add("completed-today");
          } else {
            titleEl.classList.remove("completed-today");
          }
        })
        .catch((err) => console.error(err));
    });
  });
});
