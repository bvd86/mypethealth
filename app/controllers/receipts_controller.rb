class ReceiptsController < ApplicationController
  def show
    @receipt = Receipt.find(params[:id])
    @consultation = Consultation.find(params[:consultation_id])
  end

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @receipt = Receipt.new(consultation: @consultation)
    @receipt.price_cents = 50
    @receipt.save!
    @consultation.receipt = @receipt
    @consultation.save!
    redirect_to consultation_receipt_path(@consultation, @receipt)
  end

  private

  def receipt_params
    params.require(:receipt).permit(:consultation_id, :price_cents)
  end
end
