import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "menu" ]

  connect() {
    console.log('Dropdown controller is connected!');
    document.addEventListener("click", (event) => {
      // console.log(event.target)
      if (event.target != this.contentTarget.previousElementSibling) {
      this.contentTarget.classList.remove("show");
      }

    })
  }

  showContent() {

      this.contentTarget.classList.toggle("show");
      // console.log(this.contentTarget.previousElementSibling.firstElementChild)
    }
}

// || event.target != this.contentTarget.previousElementSibling.firstElementChild
