class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  
  def create_receipt
    receipt_controller = ReceiptsController.new
    receipt_controller.request = request
    receipt_controller.response = response
    receipt_controller.create
  end
end
