class AddGuestIdToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :guest_id, :integer
  end
end
