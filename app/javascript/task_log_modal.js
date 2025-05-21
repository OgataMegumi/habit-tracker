document.addEventListener('DOMContentLoaded', () => {
  const modal = document.getElementById('taskModal');
  const modalList = document.getElementById('modalTaskList');

  document.querySelectorAll('td[data-task-titles]').forEach(cell => {
    cell.addEventListener('click', (event) => {
      event.stopPropagation();

      let titles = cell.dataset.taskTitles;
      modalList.innerHTML = '';

      if (!titles || titles.trim() === "") {
        const li = document.createElement('li');
        li.textContent = "なにもしていない日";
        modalList.appendChild(li);
      } else {
        titles.split(',').forEach(title => {
          const li = document.createElement('li');
          li.textContent = title.trim();
          modalList.appendChild(li);
        });
      }

      const rect = cell.getBoundingClientRect();
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
      const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

      modal.style.display = 'flex';
      modal.style.position = 'absolute';
      modal.style.top = `${rect.top + scrollTop + rect.height + 8}px`;
      modal.style.left = `${rect.left + scrollLeft - 25}px`;
    });
  });

  window.addEventListener('click', (event) => {
    if (!modal.contains(event.target)) {
      modal.style.display = 'none';
    }
  });
});
