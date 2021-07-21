class CreateGuestPhoneNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :guest_phone_numbers do |t|

      t.timestamps
    end
  end
end
