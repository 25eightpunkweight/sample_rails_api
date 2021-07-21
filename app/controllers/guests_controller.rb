class GuestsController < ApplicationController
  def index
    @guests = Guest.all

    render json: @guests
  end

  def create
    @guest = Guest.create(guest_params)

    render json: @guest
  end

  def show
    @guest = Guest.find(params[:id])

    render json: @guest
  end

  def update
    @guest = Guest.find(params[:id])
    @guest.update(reservation_params)

    render json: @guest
  end

  def delete
    @guests = Guest.all 
    @guest = Guest.find(params[:id])
    @guest.destroy

    render json: @guests
  end
end
