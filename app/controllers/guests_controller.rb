class GuestsController < ApplicationController
  def show
    @guest = Guest.find(params[:id])

    render json: @guest
  end
end
