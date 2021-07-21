class ChangeGuestsPhoneNumbersToArray < ActiveRecord::Migration[4.2]
  def change
    remove_column :guests, :phone_numbers
    add_column :guests, :phone_numbers, :text, { array: true, default: [] }
  end
end
