App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("notification connected")
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log("notification disconnected")
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("notification received")
    $("#notifications").prepend(data.html);
  }
});
