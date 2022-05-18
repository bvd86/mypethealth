class ConsultationsController < ApplicationController
  before_action :find_user

  def my_consultations
    @consultations = Consultation.where(user: @user)
  end

  def new
    @consultation = Consultation.new
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.user = @user

    if @consultation.save
      redirect_to my_consultations_path
    else
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new
  end

  private

  def find_user
    @user = current_user
  end

  def consultation_params
    params.require(:consultation).permit(:pet_id, :concern_category, :additional_info)
  end
end
