class PetsController < ApplicationController
  before_action :find_user

  def my_pets
    @pets = Pet.where(user: @user)
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = @user

    if @pet.save
      redirect_to my_pets_path
    else
      render :new
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :photo)
  end

  def find_user
    @user = current_user
  end
end
