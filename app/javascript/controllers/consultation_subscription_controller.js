import { Controller } from '@hotwired/stimulus'
import consumer from '../channels/consumer'

export default class extends Controller {
  static values = { consultationId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: 'ConsultationChannel', id: this.consultationIdValue },
      { received: (message) => this.#insertMessageAndScrollDown(message) }
    )

    console.log(`Subscribed to the consultation with the id ${this.consultationIdValue}.`)
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id

    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)

     this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
  this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the consultation's chat")
    this.channel.unsubscribe()
  }
}
