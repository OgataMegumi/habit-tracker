import { initializeColorSelect } from "color_select";
import { setupCharCount } from "text_limit_count";

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".edit-task-btn").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      const taskId = btn.dataset.taskId;

      fetch(`/tasks/${taskId}/edit_modal`)
        .then(res => res.text())
        .then(html => {
          document.querySelector("#editTaskModalBody").innerHTML = html;
          document.querySelector("#editTaskModal").style.display = "flex";

          const modalBody = document.querySelector("#editTaskModalBody");
          initializeColorSelect(modalBody);
            
          setupCharCount();
        });
    });
  });

  const modal = document.querySelector("#editTaskModal");
  const closeEditTaskBtn = document.getElementById('closeEditTaskModal');

  window.addEventListener("click", (event) => {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  });

  if (closeEditTaskBtn) {
    closeEditTaskBtn.addEventListener('click', () => {
      editTaskModal.style.display = 'none';
    });
  }

});
