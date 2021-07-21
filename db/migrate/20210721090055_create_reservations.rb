class CreateReservations < ActiveRecord::Migration[4.2]
  def change
    create_table :reservations do |t|
      # t.integer :reservation_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :nights
      t.integer :guests # number_of_guests 
      t.string :status # status_type
      t.string :currency # host_currency
      t.float :payout_price # alaso same as expected_payout_amount in the first payload
      t.float :security_price # also same as listing_security_price_accurate in the first payload
      t.float :total_price # total_paid_amount_accurate
      t.timestamps
    end
  end
end
