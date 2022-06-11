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
          console.log('Notifications channel disconnected!')
        },

        received: (data) => {
          // Called when there's incoming data on the websocket for this channel
          this.#insertNotification(data.html)
          // console.log('Notifications received!')
        },
      }
    )
  }

  #insertNotification(message) {
    if (!document.getElementById("request-notification")) {
      this.notificationTarget.insertAdjacentHTML("beforeend", message)
    }

    // Making sure the script is run after all DOM items are loaded
    setTimeout(() => {
      const reqNotification = document.getElementById("request-notification")
      reqNotification.addEventListener("click", ()=> {
      window.location.href = reqNotification.dataset.redirect
      })
    })
  }
}
