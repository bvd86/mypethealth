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
    @consultation.price_cents = 1900
    @consultation.status = 'pending'

    if @consultation.save!
      redirect_to available_vets_path
    else
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
    @message = Message.new

    respond_to do |format|
      format.html
        format.pdf do
          render pdf: "Consultation Id. #{@consultation.id}",
          template: "consultations/show.html.erb"
        end
     end
  end

  def start_consultation
    @consultation = @user.consultations.last
    @consultation.vet_id = params[:vet_id]

    if @consultation.save!
      # Creating and sending notification to the vet attached to the consultation
      notification = Notification.create(recipient: User.find(@consultation.vet_id),
                                         user: @consultation.user,
                                         action: "requested",
                                         notifiable: User.find(@consultation.vet_id))
      NotificationRelayJob.perform_later(notification)

      # Creating a session to process event's payment
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: "#{@consultation.pet.name}##{@consultation.id}",
          # images: '',
          amount: @consultation.price_cents,
          currency: 'cad',
          quantity: 1
        }],
        success_url: consultation_url(@consultation),
        cancel_url: consultation_url(@consultation)
      )

      @consultation.update(checkout_session_id: session.id)

      redirect_to new_consultation_payment_path(@consultation)
    else
      render :new
    end
  end

  def end_consultation
    @consultation = Consultation.find(params[:consultation][:id])
    @consultation.update!(active: false)

    if current_user.id == @consultation.vet_id
      create_receipt
      redirect_to consultation_receipt_path(@consultation, @consultation.receipt)
    else
      redirect_to new_consultation_feedback_path(@consultation)
    end
  end

  private

  def find_user
    @user = current_user
  end

  def consultation_params
    params.require(:consultation).permit(:pet_id, :concern_category, :additional_info, :user, :active, :species)
  end
end
