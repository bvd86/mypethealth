class FeedbacksController < ApplicationController
  before_action :find_user
  before_action :find_consultation, only: [:new, :create]

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = @user
    @feedback.consultation = @consultation

    if @feedback.save!
      create_receipt
      redirect_to consultation_receipt_path(@feedback.consultation, @feedback.consultation.id)
    else
      render :new
    end
  end

  def create_receipt
    receipt_controller = ReceiptsController.new
    receipt_controller.request = request
    receipt_controller.response = response
    receipt_controller.create
  end

  private

  def find_user
    @user = current_user
  end

  def feedback_params
    params.require(:feedback).permit(:user, :consultation, :rating, :vet_rating, :friend_rating, :comment)
  end

  def find_consultation
    @consultation = Consultation.find(params[:consultation_id])
  end

end
