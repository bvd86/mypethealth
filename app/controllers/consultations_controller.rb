class ConsultationsController < ApplicationController
  before_action :find_user

  def my_consultations
    @consultations = Consultation.where(user: @user)
  end

  def new
  end

  def create
  end

  def show
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new
  end

  private

  def find_user
    @user = current_user
  end
end
