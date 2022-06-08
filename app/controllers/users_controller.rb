class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :my_profile,
                                   :make_available, :make_unavailable,
                                   :available_vets, :remove_photo, :change_vet_status]

  def my_profile; end

  def edit; end

  def update
    # Cleaning empty specialty
    specialty_ids = params[:user][:specialty_ids].select {|s| !s.empty? }

    # Updating user specialties associations
    @user.specialties = specialty_ids.map { |id| Specialty.find(id) }

    # Saving user
    @user.update!(user_params)

    # Resize image (for pdf)
    user_photo_id = @user.photo.id

    unless Rails.env.test?
      unless user_photo_id == @user.photo.id
        ResizePhotoJob.set(wait: 2.seconds).perform_later("User", @user.id, :photo, 120, 120)
      end
    end

    redirect_to my_profile_path
  end

  def change_vet_status
    @user.available ? @user.update!(available: false) : @user.update!(available: true)
  end

  def remove_photo
    @user.photo.destroy

    redirect_to my_profile_path
  end

  def available_vets
    # Get species from last consult from to filter vets
    @species = @user.consultations.last.pet.species.downcase

    # Find specialty by species defined by pet that's consulting
    # Returns a Hash of Arrays
    @wanted_specialties = Specialty::SPECIALTIES.select do |k, v|
      v.include?(@species)
    end

    # Display available vets only if their specialty is needed
    @available_vets_customized = User.joins(:specialties)
                                # filter by available vets
                                .where(users: {available: true})
                                # filter by specialty required by the pet
                                .where(specialties: {name: @wanted_specialties.keys})
  end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :specialty_ids, :available, :photo)
  end
end
