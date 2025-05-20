document.addEventListener('DOMContentLoaded', () => {
  const newTaskModal = document.getElementById('newTaskModal');
  const openNewTaskBtn = document.getElementById('openNewTaskModal');

  openNewTaskBtn.addEventListener('click', () => {
    newTaskModal.style.display = 'flex';
  });

  // newTaskClose.addEventListener('click', () => {
  //   newTaskModal.style.display = 'none';
  // });

  window.addEventListener('click', (event) => {
    if (event.target === newTaskModal) {
      newTaskModal.style.display = 'none';
    }
  });
});
