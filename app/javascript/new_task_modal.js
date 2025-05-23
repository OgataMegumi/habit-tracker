document.addEventListener('DOMContentLoaded', () => {
  const newTaskModal = document.getElementById('newTaskModal');
  const openNewTaskBtn = document.getElementById('openNewTaskModal');
  const closeNewTaskBtn = document.getElementById('closeNewTaskModal');

  if (openNewTaskBtn) {
    openNewTaskBtn.addEventListener('click', () => {
      newTaskModal.style.display = 'flex';
    });
  }

  if (closeNewTaskBtn) {
    closeNewTaskBtn.addEventListener('click', () => {
      newTaskModal.style.display = 'none';
    });
  }

  window.addEventListener('click', (event) => {
    if (event.target === newTaskModal) {
      newTaskModal.style.display = 'none';
    }
  });
});
