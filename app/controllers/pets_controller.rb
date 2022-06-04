class PetsController < ApplicationController
  before_action :find_user
  before_action :find_pet, only: [ :edit, :update, :destroy ]

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = @user

    if @pet.save
      redirect_to my_profile_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @pet.update(pet_params)

    redirect_to my_profile_path
  end

  # Removing pet deletion method because of dependency with consultations
  # def destroy
  #   @pet.destroy!

  #   redirect_to my_profile_path
  # end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :photo)
  end

  def find_user
    @user = current_user
  end

  def find_pet
    @pet = Pet.find(params[:id])
  end
end
