class Materials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :section
      t.string :cat_1
      t.string :cat_2
      t.string :cat_3

      t.timestamps
    end
  end
end
