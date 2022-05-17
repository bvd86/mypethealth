class ConsultationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    consultation = Consultation.find(params[:id])
    stream_for consultation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
