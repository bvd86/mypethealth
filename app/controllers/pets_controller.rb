class PetsController < ApplicationController
  before_action :find_user
  before_action :set_pet, only: %i[show]

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = @user

    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def show; end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :photo)
  end

  def find_user
    @user = current_user
  end
end
