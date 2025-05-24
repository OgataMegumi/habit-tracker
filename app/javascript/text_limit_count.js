export function setupCharCount() {
  const modalBodies = [
    document.querySelector("#editTaskModalBody"),
    document.querySelector("#newTaskModalBody")
  ];

  const fieldsMap = {
    new_task_title: { counterId: "new_title_char_count", max: 15 },
    new_task_description: { counterId: "new_description_char_count", max: 50 },
    new_task_message: { counterId: "new_message_char_count", max: 50 },
    edit_task_title: { counterId: "edit_title_char_count", max: 15 },
    edit_task_description: { counterId: "edit_description_char_count", max: 50 },
    edit_task_message: { counterId: "edit_message_char_count", max: 50 }
  };

  modalBodies.forEach((modalBody) => {
    if (!modalBody) return;

    modalBody.addEventListener("input", (event) => {
      const input = event.target;
      const config = fieldsMap[input.id];
      if (!config) return;

      const counter = document.getElementById(config.counterId);
      if (!counter) return;

      const length = input.value.length;
      counter.textContent = `${length}/${config.max}`;
    });
  });

  Object.entries(fieldsMap).forEach(([id, { counterId, max }]) => {
    const input = document.getElementById(id);
    const counter = document.getElementById(counterId);
    if (input && counter) {
      const length = input.value.length;
      counter.textContent = `${length}/${max}`;
    }
  });
}
