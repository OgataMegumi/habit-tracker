export function initializeColorSelect(root = document) {
  const colorInput = root.querySelector('input[name="task[color]"]');
  const swatches = root.querySelectorAll('.color-swatch');

  if (!colorInput || swatches.length === 0) return;

  function selectColor(selectedName) {
    colorInput.value = selectedName;
    swatches.forEach(swatch => {
      swatch.classList.toggle("selected", swatch.dataset.colorName === selectedName);
    });
  }

  if (colorInput.value) {
    selectColor(colorInput.value);
  }

  swatches.forEach(swatch => {
    swatch.addEventListener('click', () => {
      selectColor(swatch.dataset.colorName);
    });
  });
}

document.addEventListener("DOMContentLoaded", () => {
  initializeColorSelect();
});
