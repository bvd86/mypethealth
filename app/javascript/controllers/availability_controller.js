import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "available" ]

  connect() {
    console.log('Hello!!');

  }

  toggle(event) {
    if (this.element.checked) {
      console.log("toggle event checked");
      console.log(this.element.outerHTML);
    } else if (this.element.checked === false) {
      console.log("toggle event unchecked");
      console.log(this.element.innerHTML);
    }
  }
}
