class RemoveGuestDetail < ActiveRecord::Migration[4.2]
  def change
    drop_table :guest_details, if_exists: true
    add_column :reservations, :adults, :integer
    add_column :reservations, :children, :integer
    add_column :reservations, :infants, :integer
    add_column :reservations, :description, :string
  end
end
