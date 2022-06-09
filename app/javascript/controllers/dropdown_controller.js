import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "menu" ]

  connect() {
    console.log('Dropdown controller is connected!');
    document.addEventListener("click", (event) => {
      if (event.target != this.contentTarget.previousElementSibling) {
      this.contentTarget.classList.remove("show");
      }

    })
  }

  showContent() {
      this.contentTarget.classList.add("show");
    }

}
