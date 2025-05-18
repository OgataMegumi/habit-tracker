document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".task-card").forEach(card => {
    card.addEventListener("click", () => {
      const url = card.dataset.url;
      if (url) {
        window.location.href = url;
      }
    });
  });
});
