document.addEventListener('DOMContentLoaded', () => {
  const modal = document.getElementById('taskModal');
  const modalList = document.getElementById('modalTaskList');

  document.querySelectorAll('td[data-task-titles]').forEach(cell => {
    cell.addEventListener('click', () => {
      const titles = cell.dataset.taskTitles.split(',');

      modalList.innerHTML = '';
      titles.forEach(title => {
        const li = document.createElement('li');
        li.textContent = title;
        modalList.appendChild(li);
      });

      const rect = cell.getBoundingClientRect();
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
      const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

      modal.style.display = 'flex';
      modal.style.position = 'absolute';
      modal.style.top = `${rect.top + scrollTop + rect.height + 8}px`;
      modal.style.left = `${rect.left + scrollLeft - 25}px`;
    });
  });

  // window.addEventListener('click', (event) => {
  //   if (event.target === modal) {
  //     modal.style.display = 'none';
  //   }
  // });

  // window.addEventListener('click', (event) => {
  //   // クリックされた要素がモーダルではなく、かつモーダルの子要素でもない場合に閉じる
  //   if (!modal.contains(event.target)) {
  //     modal.style.display = 'none';
  //   }
  // });

  modal.addEventListener('click', (event) => {
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  });
});
