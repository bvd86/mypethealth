import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { consultationId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ConsultationChannel", id: this.consultationIdValue },
      { received: (message) => {
        this.messagesTarget.insertAdjacentHTML("beforeend", message)
        this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight) } }
    )

    console.log(`Subscribed to the consultation with the id ${this.consultationIdValue}.`)
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the consultation's chat")
    this.channel.unsubscribe()
  }
}
