class ReceiptsController < ApplicationController
  def show
    @receipt = Receipt.find(params[:id])
    @consultation = Consultation.find(params[:consultation_id])
    @vet = User.find(@consultation.vet_id)
    if @consultation.feedback
     @feedback_avg = (@consultation.feedback.rating + @consultation.feedback.vet_rating + @consultation.feedback.friend_rating)/3
    end
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
