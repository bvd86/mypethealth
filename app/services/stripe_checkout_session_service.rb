class StripeCheckoutSessionService
  def call(event)
    @event = Event.find_by(checkout_session_id: event.data.object.id)
    @event.update!(status: 'paid')
  end
end
