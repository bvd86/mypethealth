class ConsultationsController < ApplicationController

  def show
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new
  end
end
