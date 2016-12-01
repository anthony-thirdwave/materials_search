class AddMaterialSearchesView < ActiveRecord::Migration[5.0]
  def up
  	ActiveRecord::Base.connection.execute <<-SQL
  		CREATE OR REPLACE VIEW material_searches AS

  			SELECT materials.id AS searchable_id,
  			'Material' AS searchable_type,
  			materials.section AS term
  			FROM materials

  			UNION

  			SELECT materials.id AS searchable_id,
  			'Material' AS searchable_type,
  			materials.cat_1 AS term
  			FROM materials

        UNION

  			SELECT materials.id AS searchable_id,
  			'Material' AS searchable_type,
  			materials.cat_2 AS term
  			FROM materials

        UNION

  			SELECT materials.id AS searchable_id,
  			'Material' AS searchable_type,
  			materials.cat_3 AS term
  			FROM materials

  	SQL
  end

  def down
  	ActiveRecord::Base.connection.execute <<-SQL
  	DROP VIEW material_searches;
  	SQL
  end
end
