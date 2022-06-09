import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = [ "available" ]

  connect() {
    console.log('Availability controller is now connected!!');

  }

  toggle(event) {
    // if (this.element.checked) {
    //   console.log("toggle event checked");
    //   console.log(this.element.outerHTML);
    // } else if (this.element.checked === false) {
    //   console.log("toggle event unchecked");
    //   console.log(this.element.innerHTML);
    // }
    let formData = new FormData();
    formData.append("user[available]", this.availableTarget.checked )

    fetch(this.data.get("update-url"), {
      method: "PATCH",
      dataType: 'script',
      credentials: "include",
      headers: { "X-CSRF-Token": getMetaValue("csrf-token") },
    })
      .then(function(response) {
        if (response.status != 204) {
            event.target.checked = !event.target.checked
        }
      })
      .then((data) => {
        console.log(data)
      })
  }



}
