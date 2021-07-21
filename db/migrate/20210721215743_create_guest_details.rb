class CreateGuestDetails < ActiveRecord::Migration[4.2]
  def change
    create_table :guest_details do |t|
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :localized_description
      t.timestamps
    end
  end
end
