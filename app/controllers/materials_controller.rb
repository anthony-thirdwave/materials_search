class MaterialsController < ApplicationController
	before_action :find_material, only: [:edit, :update, :show, :delete]

	# Index action to render all materials
	def index
		@companies = []
    if params[:query].nil?
      @materials = []
    else
      @materials = Material.search params[:query]
      @materials.each do |material|
        material.companies.each do |company|
          if !@companies.include? company
            @companies << company
          end
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

	def autocomplete
		render json: Material.search(params[:query], autocomplete: false, limit: 10).map do |material|
			{ title: material.cat_2, value: material.id }
		end
	end

	private

	def material_params
		params.require(:material).permit(:section, :cat_1, :cat_2, :cat_3)
	end

	def find_material
		@material = Material.find(params[:id])
	end
end
