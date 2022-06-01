class ReceiptsController < ApplicationController
  def show
    @receipt = Receipt.where(consultation: params[:id])
    @consultation = Consultation.find(params[:consultation_id])
  end

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @receipt = Receipt.new(consultation: @consultation)
    @receipt.price_cents = 50
    @receipt.save!
    redirect_to consultation_receipt_path(@consultation, @consultation.id)
  end

  private

  def receipt_params
    params.require(:receipt).permit(:consultation_id, :price_cents)
  end
end
