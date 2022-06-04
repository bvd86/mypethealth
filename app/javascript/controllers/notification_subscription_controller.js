import { Controller } from '@hotwired/stimulus'
import consumer from '../channels/consumer'

export default class extends Controller {
  static targets = ['notification']
  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: 'NotificationsChannel' },
      {
        connected: function () {
          // Called when the subscription is ready for use on the server
          console.log('Notifications channel connected!')
        },

        disconnected: function () {
          // Called when the subscription has been terminated by the server
          this.channel.unsubscribe()
        },

        received: (data) => {
          // Called when there's incoming data on the websocket for this channel
          this.#insertNotification(data.html)
        },
      }
    )
  }

  #insertNotification(message) {
    this.notificationTarget.prepend(message)
  }
}
