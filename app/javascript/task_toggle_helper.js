export function withLoading(card, asyncFunc) {
  card.classList.add('loading');
  card.style.pointerEvents = 'none';

  return asyncFunc()
    .finally(() => {
      card.classList.remove('loading');
      card.style.pointerEvents = 'auto';
    });
}
