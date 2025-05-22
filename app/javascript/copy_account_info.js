
document.addEventListener('DOMContentLoaded', () => {
  const toast = document.getElementById('toast');

  function showToast(message) {
    toast.textContent = message;
    toast.style.opacity = '1';
    toast.style.pointerEvents = 'auto';

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.pointerEvents = 'none';
    }, 1000);
  }

  document.querySelectorAll('.copy-text').forEach(el => {
    el.addEventListener('click', () => {
      const text = el.dataset.copy;

      navigator.clipboard.writeText(text).then(() => {
        showToast(`${text}をコピーしました`);
      }).catch(() => {
        showToast('コピーに失敗しました');
      });
    });
  });
});
