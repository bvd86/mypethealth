class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :my_profile,
                                   :make_available, :make_unavailable,
                                   :available_vets, :remove_photo]

  def my_profile; end

  def edit; end

  def update
    # Cleaning empty specialty
    specialty_ids = params[:user][:specialty_ids].select {|s| !s.empty? }

    # Updating user specialties associations
    @user.specialties = specialty_ids.map { |id| Specialty.find(id) }

    # Saving user
    @user.update!(user_params)

    redirect_to my_profile_path(@user)
  end

  def make_available
    @user.update!(available: true)

    redirect_to my_profile_path(@user)
  end

  def make_unavailable
    @user.update!(available: false)

    redirect_to my_profile_path(@user)
  end

  def remove_photo
    @user.photo.destroy

    redirect_to my_profile_path(@user)
  end

  def available_vets
      @available_vets = User.all.where(available: true)
  end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :specialty_ids, :available, :photo)
  end
end
