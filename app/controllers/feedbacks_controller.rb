class FeedbacksController < ApplicationController
  before_action :find_user
  before_action :find_consultation, only: [:new, :create]

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    @feedback = Feedback.new
    @consultation = Consultation.find(params[:consultation_id])
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = @user
    @feedback.consultation = @consultation

    if @feedback.save!
      redirect_to receipt_path(@feedback.consultation)
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
