import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "content", "menu" ]

  connect() {
    console.log('Dropdown controller is connected!')
  }

  showContent() {
    console.log(this.contentTarget)
    this.contentTarget.classList.toggle("show")
  }
}
