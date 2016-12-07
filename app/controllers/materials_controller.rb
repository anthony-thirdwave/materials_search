class MaterialsController < ApplicationController
	before_action :find_material, only: [:edit, :update, :show, :delete]

	# Index action to render all materials
	def index
		query = params[:query].presence || '*'
    @materials = Material.search query, aggs: [:section, :cat_1, :cat_2, :cat_3]
    @companies = @materials.map(&:companies).flatten.uniq
		@aggs = @materials.aggs

		# Needs to be refactored
		if @companies.map(&:name).include? query
			@companies.each do |company|
				if company.name = query
					@companies = [company]
				end
			end
		end
	end

	# New action for creating material
	def new
		@material = Material.new
	end

	# Create action saves the material into database
	def create
		@material = Material.new(material_params)
		if @material.save
			flash[:notice] = "Successfully created material!"
			redirect_to material_path(@material)
		else
			flash[:alert] = "Error creating new material!"
			render :new
		end
	end

	# Edit action retrives the material and renders the edit page
	def edit
	end

	# Update action updates the material with the new information
	def update
		if @material.update_attributes(material_params)
			flash[:notice] = "Successfully updated material!"
			redirect_to material_path(@material)
		else
			flash[:alert] = "Error updating material!"
			render :edit
		end
	end

	# The show action renders the individual material after retrieving the the id
	def show
	end

	# The destroy action removes the material permanently from the database
	def destroy
		if @material.destroy
			flash[:notice] = "Successfully deleted material!"
			redirect_to materials_path
		else
			flash[:alert] = "Error updating material!"
		end
	end

	def filters
	  allowed_filters = %w(cat_1 size)
	  filters = params.select{|k, v| allowed_filters.include?(k) }
	end
	helper_method :filters

	def autocomplete
		a = Material.search(params[:term], fields: [{cat_2: :text_start}], limit: 10).map(&:cat_2)
		b = Company.search(params[:term], fields: [{name: :text_start}], limit: 10).map(&:name)
		c = Material.search(params[:term], fields: [{cat_2: :text_start}], limit: 10).map(&:cat_3)
		d = (a + b + c).uniq
		render json: d
	end

	private

	def material_params
		params.require(:material).permit(:section, :cat_1, :cat_2, :cat_3)
	end

	def find_material
		@material = Material.find(params[:id])
	end
end
