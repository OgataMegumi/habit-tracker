document.addEventListener("DOMContentLoaded", () => {
  const numberSelect = document.getElementById("task_frequency_number");
  const unitSelect = document.getElementById("task_frequency_unit");

  if (!numberSelect || !unitSelect) return;

  const unitOptions = {
    "時間": 24,
    "日": 30,
    "週": 7,
    "ヶ月": 12
  };

  unitSelect.addEventListener("change", () => {
    const unit = unitSelect.value;
    const max = unitOptions[unit] || 12;

    numberSelect.innerHTML = "";

    for (let i = 1; i <= max; i++) {
      const option = document.createElement("option");
      option.value = i;
      option.textContent = i;
      numberSelect.appendChild(option);
    }
  });

  const event = new Event('change');
  unitSelect.dispatchEvent(event);
});
