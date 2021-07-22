class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all

    render json: @guests
  end

  def create
    guest = Guest.create(guest_attributes(params))
    @reservation = Reservation.new(reservation_attributes(params))
    @reservation.guest = guest

    if @reservation.save
      render json: {
        reservation: @reservation,
        guest: guest
      }
    else 
      render json: { status: @reservation.error }
    end
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

  def destroy
    @reservations = Reservation.all 
    @reservation = Reservation.find(params[:id])
    @reservation.guest.destroy
    @reservation.destroy

    render json: @reservations
  end

  private

  def reservation_attributes(params)
    reservation_params(params).permit(
      :start_date, :end_date, :nights, :number_of_guests, :adults, :children,
      :infants, :status, :currency,:payout_price, :security_price, :total_price, :description
    )
  end

  def guest_attributes(params)
    guest_params(params).permit(:id, :first_name, :last_name, :phone_numbers, :email)
  end

  def reservation_params(params)
    # editing params here before using strong params
    # if more different payloads come in, this is where we adjust the mapping
    # so that before we apply strong params, it's already a hash that the 
    # api can recognize as attributes
    params = params['reservation'].present? ? params['reservation'] : params
    ActionController::Parameters.new({
      'start_date' => params['start_date'],
      'end_date' => params['end_date'],
      'nights' => params['nights'],
      'number_of_guests' => params['number_of_guests'] || params['guests'],
      'status' => params['status'] || params['status_type'],
      'currency' => params['currency'] || params['host_currency'],
      'payout_price' => params['payout_price'] || params['expected_payout_amount'],
      'security_price' => params['security_price'] || params['listing_security_price_accurate'],
      'total_price' => params['total_price'] || params['total_paid_amount_accurate'],
      'adults' => params['adults'] || params['guest_details']['number_of_adults'],
      'children' => params['children'] || params['guest_details']['number_of_children'],
      'infants' => params['infants'] || params['guest_details']['number_of_infants'],
      'description' => description_string(params) || params['guest_details']['localized_description'],
    })
  end

  def guest_params(params)
    # again, editing the params here before applying strong params
    ActionController::Parameters.new({
      'id' => params.dig('guest', 'id') || params['guest_id'],
      'first_name' => params.dig('guest', 'first_name') || params['guest_first_name'],
      'last_name' => params.dig('guest', 'last_name') || params['guest_last_name'],
      'phone_numbers' => [ params.dig('guest', 'phone') ] || params['guest_phone_numbers'],
      'email' => params.dig('guest', 'email') || params['guest_email'],
    })
  end

  def description_string(params)
    return if !params.dig('infants')
    "#{params['infants'] + params['children'] + params['adults']} guests"
  end
end
