class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :my_profile]

  def edit; end

  def update
    @user.update(user_params)

    redirect_to edit_user_path(@user)
  end

  def my_profile; end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :specialty, :available)
  end
end
