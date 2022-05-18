class MessagesController < ApplicationController
  def create
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new(message_params)
    @message.consultation = @consultation
    @message.user = current_user
    if @message.save!
      ConsultationChannel.broadcast_to(
        @consultation,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "consultations/show"
    end
  end
end
