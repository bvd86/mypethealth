import { Controller } from '@hotwired/stimulus'
import consumer from '../channels/consumer'

// Refactoring from this tutorial: https://gist.github.com/excid3/4ca7cbead79f06365424b98fa7f8ecf6
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
          console.log("Shoudl be data:", data)
          this.#insertNotification(data.html)
        },
      }
    )
  }

  #insertNotification(message) {
    this.notificationTarget.prepend(message)
  }
}
