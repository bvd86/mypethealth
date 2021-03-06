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
    @feedback.user = User.find(@consultation.vet_id)
    @feedback.consultation = @consultation

    if @feedback.save!
      create_receipt
      redirect_to consultation_receipt_path(@feedback.consultation, @feedback.consultation.receipt)
    else
      render :new
    end
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
