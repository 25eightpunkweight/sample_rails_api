class ChangeGuestsToNumberOfGuests < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :guests, :number_of_guests
  end
end
