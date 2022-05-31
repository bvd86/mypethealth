class ReceiptsController < ApplicationController
  def show
    # @receipt = Receipt.find(params[:id])
  end

  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.save!
  end

  private

  def receipt_params
    params.require(:receipt).permit(:consultation, :price)
  end
end
