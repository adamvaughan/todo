let form = document.getElementById("edit_list_form");

if (form) {
  let input = form.querySelector("#list_title");

  input.addEventListener("keydown", event => {
    if (event.isComposing || event.keyCode === 229) {
      return;
    }

    if (event.key == "Escape" || event.key == "Esc") {
      event.preventDefault();
      window.location = input.dataset.cancelUrl;
    }
  });
}
