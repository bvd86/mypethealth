import consumer from './consumer'

consumer.subscriptions.create('NotificationsChannel', {
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
})
