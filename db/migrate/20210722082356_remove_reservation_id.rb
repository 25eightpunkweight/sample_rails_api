class RemoveReservationId < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :reservation_id
  end
end
