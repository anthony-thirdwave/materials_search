class CreateCompaniesMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :companies_materials do |t|
      t.references :material, foreign_key: true
      t.references :company, foreign_key: true
    end
  end
end
