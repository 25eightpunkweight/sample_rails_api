class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all

    render json: @guests
  end

  def create
    binding.pry
    guest = Guest.create(guest_attributes)
    @reservation = Reservation.new(reservation_params)
    @reservation.guest = guest

    if @reservation.save
      render json: @reservation
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

  def reservation_params 
    att = params.require(:reservation).permit(
      :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :status, :currency, :payout_price, :security_price, :total_price,
      :expected_payout_amount,
      :listing_security_price_accurate, :host_currency, :number_of_guests, :status_type, :total_paid_amount_accurate,
      guest_details: %i[localized_description number_of_adults number_of_children number_of_infants],
    )

    {
      'start_date' => att['start_date'],
      'end_date' => att['end_date'],
      'nights' => att['nights'],
      'number_of_guests' => att['guests'] || att['number_of_guests'],
      'status' => att['status'] || att['status_type'],
      'currency' => att['currency'] || att['host_currency'],
      'security_price' => att['security_price'] || att['listing_security_price_accurate'],
      'total_price' => att['total_price'] || att['total_paid_amount_accurate'],
      'adults' => att['adults'] || att['guest_details']['number_of_adults'],
      'children' => att['children'] || att['guest_details']['number_of_children'],
      'infants' => att['infants'] || att['guest_details']['number_of_infants'],
      'description' => att['guest_details']['localized_description'] || "#{att['infants'] + att['children'] + att['adults']} guests",
    }
  end

  def guest_attributes  
    if params['guest'].present?
      att = params.require(:guest).permit(:id, :first_name, :last_name, :phone, :email)
      {
        'id' => att['id'],
        'first_name' => att['first_name'],
        'last_name' => att['last_name'],
        'phone_numbers' => [ att['phone'] ],
        'email' => att['email'],
      }
    else
      att = params.require(:reservation).permit(
        :guest_email, :guest_id, :guest_last_name, :guest_first_name,
        guest_phone_numbers: %i[]
      )
      {
        'id' => att['guest_id'],
        'first_name' => att['guest_first_name'],
        'last_name' => att['guest_last_name'],
        'phone_numbers' => att['guest_phone_numbers'],
        'email' => att['guest_email'],
      }
    end
  end
end
