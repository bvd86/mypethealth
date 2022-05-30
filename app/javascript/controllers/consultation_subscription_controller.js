import { Controller } from '@hotwired/stimulus'
import consumer from '../channels/consumer'

export default class extends Controller {
  static values = { consultationId: Number }
  static targets = ['messages']

  connect() {
    console.log('hey')
    this.channel = consumer.subscriptions.create(
      { channel: 'NotificationsChannel' },
      {
        connected: function () {
          // Called when the subscription is ready for use on the server
          console.log('ok')
        },

        disconnected: function () {
          // Called when the subscription has been terminated by the server
        },

        received: function (data) {
          // Called when there's incoming data on the websocket for this channel
          $('#notifications').prepend(data.html)
        },
      }
    )

    console.log(`Subscribed to the consultation with the id ${this.consultationIdValue}.`)
  }

  // #insertMessageAndScrollDown(message) {
  //   this.messagesTarget.insertAdjacentHTML('beforeend', message)
  //   this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  // }

  // resetForm(event) {
  //   event.target.reset()
  // }

  // disconnect() {
  //   console.log("Unsubscribed from the consultation's chat")
  //   this.channel.unsubscribe()
  // }
}
