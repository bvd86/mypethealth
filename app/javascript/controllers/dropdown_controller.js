import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "menu" ]

  connect() {
    console.log('Dropdown controller is connected!');
    document.addEventListener("click", () => {
      this.contentTarget.classList.toggle("show");
    })
  }

  showContent() {
    this.contentTarget.classList.toggle("show");
  }
}
