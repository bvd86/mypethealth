class ConsultationsController < ApplicationController
  before_action :find_user

  def my_consultations
    @consultations = Consultation.where(user: @user)
  end

  def pet_consultations
    @pet = Pet.find(params[:pet_id])
    @consultations = Consultation.where(pet: @pet)
  end

  def new
    @consultation = Consultation.new
    @pets = @user.pets
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.user = @user

    if @consultation.save!
      redirect_to available_vets_path
    else
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
    @message = Message.new
  end

  def start_consultation
    @consultation = Consultation.last
    @consultation.vet_id = params[:vet_id]

    if @consultation.save!
      redirect_to consultation_path(@consultation)
    else
      render :new
    end
  end

  def end_consultation
    @consultation = Consultation.find(params[:consultation][:id])
    @consultation.update!(active: false)
    redirect_to new_consultation_feedback_path(@consultation)
  end

  private

  def find_user
    @user = current_user
  end

  def consultation_params
    params.require(:consultation).permit(:pet_id, :concern_category, :additional_info, :user, :active, :species)
  end
end
