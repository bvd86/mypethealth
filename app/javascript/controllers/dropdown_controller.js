import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "menu" ]

  connect() {
    console.log('Dropdown controller is connected!');
    document.addEventListener("click", () => {
      console.log(this.event.target)
      if (this.event.target != this.contentTarget) {
      this.contentTarget.classList.remove("show");
      }

    })
  }

  showContent() {

      this.contentTarget.classList.toggle("show");
      console.log(this.event.target)
    }

  hideContent() {

    this.contenTarget.classList.remove("show");
  }
}
