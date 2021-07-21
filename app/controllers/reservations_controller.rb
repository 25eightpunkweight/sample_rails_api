class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all

    render json: @guests
  end

  def create
    @reservation = Reservation.create(reservation_params)

    render json: @reservation
  end

  def show
    @reservation = Reservation.find(params[:id])

    render json: @reservation
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)

    render json: @reservation
  end

  def delete
    @reservations = Reservation.all 
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    render json: @reservations
  end

  private

  def reservation_params
    params.permit()
  end
end
