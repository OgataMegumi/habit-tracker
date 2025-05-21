document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".dropdown-toggle").forEach(button => {
    button.addEventListener("click", () => {
      const menu = button.nextElementSibling;
      if (menu && menu.classList.contains("dropdown-menu")) {
        menu.hidden = !menu.hidden;
      }
    });
  });

  document.addEventListener("click", (e) => {
    document.querySelectorAll(".dropdown-menu").forEach(menu => {
      if (!menu.hidden && !menu.parentElement.contains(e.target)) {
        menu.hidden = true;
      }
    });
  });
});
