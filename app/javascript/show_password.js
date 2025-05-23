document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".toggle-password-visibility").forEach(icon => {
    icon.addEventListener("click", () => {
      const targetId = icon.getAttribute("data-target");
      const input = document.getElementById(targetId);
      if (!input) return;

      const isPassword = input.type === "password";
      input.type = isPassword ? "text" : "password";

      if (!input.classList.contains("password-input")) {
        input.classList.add("password-input");
      }

      const iTag = icon.querySelector("i");
      if (isPassword) {
        iTag.classList.remove("fa-eye-slash");
        iTag.classList.add("fa-eye");
      } else {
        iTag.classList.remove("fa-eye");
        iTag.classList.add("fa-eye-slash");
      }
    });
  });
});
