document.addEventListener("DOMContentLoaded", function () {
  const fields = [
    { id: "task_title", countId: "title_char_count", max: 15 },
    { id: "task_description", countId: "description_char_count", max: 50 },
    { id: "task_message", countId: "message_char_count", max: 50 }
  ];

  fields.forEach(({ id, countId, max }) => {
    const input = document.getElementById(id);
    const counter = document.getElementById(countId);

    if (input && counter) {
      const update = () => {
        const length = input.value.length;
        counter.textContent = `${length}/${max}`;
      };

      input.addEventListener("input", update);
      update(); // 初期表示用
    }
  });
});
