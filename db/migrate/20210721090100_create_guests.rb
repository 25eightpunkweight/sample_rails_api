class CreateGuests < ActiveRecord::Migration[4.2]
  def change
    create_table :guests do |t|
      # t.integer :id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_numbers, :tags, array: true, default: []
      t.timestamps
    end
  end
end
