class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def create_receipt
    receipt_controller = ReceiptsController.new
    receipt_controller.request = request
    receipt_controller.response = response
    receipt_controller.create
  end
end
