class FeedbacksController < ApplicationController
  before_action :find_user

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    @feedback = Feedback.new
  end

  def create
  end

  private

  def find_user
    @user = current_user
  end
end
