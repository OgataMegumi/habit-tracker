document.addEventListener('DOMContentLoaded', () => {
  const colorInput = document.getElementById('color_input');
  const swatches = document.querySelectorAll('.color-swatch');

  function selectColor(color) {
    colorInput.value = color;
    swatches.forEach(swatch => {
      if (swatch.dataset.color === color) {
        swatch.style.borderColor = 'black';
      } else {
        swatch.style.borderColor = 'transparent';
      }
    });
  }

  if (colorInput.value) {
    selectColor(colorInput.value);
  }

  swatches.forEach(swatch => {
    swatch.addEventListener('click', () => {
      selectColor(swatch.dataset.color);
    });
  });
});