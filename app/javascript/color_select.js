document.addEventListener('DOMContentLoaded', () => {
  const colorInput = document.getElementById('task_color');
  const swatches = document.querySelectorAll('.color-swatch');

  function selectColor(selectedName) {
    colorInput.value = selectedName;

    swatches.forEach(swatch => {
      const name = swatch.dataset.colorName;

      if (name === selectedName) {
        swatch.classList.add("selected");
      } else {
        swatch.classList.remove("selected");
      }
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
});
