class RemoveGuestPhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    drop_table :guest_phone_numbers, if_exists: true
  end
end
