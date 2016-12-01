class AddMaterialSearchesIndices < ActiveRecord::Migration[5.0]
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE INDEX index_materials_on_section ON materials USING gin(to_tsvector('english', section));
      CREATE INDEX index_materials_on_cat_1 ON materials USING gin(to_tsvector('english', cat_1));
      CREATE INDEX index_materials_on_cat_2 ON materials USING gin(to_tsvector('english', cat_2));
      CREATE INDEX index_materials_on_cat_3 ON materials USING gin(to_tsvector('english', cat_3));
    SQL
  end

  def down
    ActiveRecord::Base.connection.execute <<-SQL
      DROP INDEX index_materials_on_section;
      DROP INDEX index_materials_on_cat_1;
      DROP INDEX index_materials_on_cat_2;
      DROP INDEX index_materials_on_cat_3;
    SQL
  end
end
