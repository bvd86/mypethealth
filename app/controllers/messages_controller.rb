class MessagesController < ApplicationController
  def create
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new(message_params)
    @message.consultation = @consultation
    @message.user = current_user
    if @message.save
      ConsultationChannel.broadcast_to(
        @consultation,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
    else
      render "consultations/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :photo)
  end
end
