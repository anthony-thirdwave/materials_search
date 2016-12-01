class Companies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
    end
  end
end
