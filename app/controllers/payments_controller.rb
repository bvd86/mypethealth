class PaymentsController < ApplicationController
  def new
    @consultation = current_user.consultations.where(status: 'pending').find(params[:consultation_id])
  end
end
