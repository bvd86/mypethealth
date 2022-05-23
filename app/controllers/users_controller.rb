class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :my_profile]

  def my_profile; end

  def edit; end

  def update
    params[:user][:specialty_ids] = params[:user][:specialty_ids].select {|s| !s.empty? } if params[:user][:specialty_ids] != nil
    @user.update!(user_params)
    raise
    redirect_to edit_user_path(@user)
  end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :specialty_ids, :available)
  end
end
