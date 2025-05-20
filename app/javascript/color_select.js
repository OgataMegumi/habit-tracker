document.addEventListener('DOMContentLoaded', () => {
  const colorInput = document.getElementById('color_input');
  const swatches = document.querySelectorAll('.color-swatch');

  function selectColor(selectedName) {
    colorInput.value = selectedName;

    swatches.forEach(swatch => {
      const name = swatch.dataset.colorName;
      const code = swatch.dataset.colorCode;
      swatch.style.borderColor = name === selectedName ? 'white' : code;
    });
  }

  // 初期値のハイライト
  if (colorInput.value) {
    selectColor(colorInput.value);
  }

  swatches.forEach(swatch => {
    swatch.addEventListener('click', () => {
      selectColor(swatch.dataset.colorName);
    });
  });
});
