class CompaniesController < ApplicationController
	before_action :find_company, only: [:edit, :update, :show, :delete]

	# Index action to render all companies
	def index
		@companies = Company.all
	end

	# New action for creating company
	def new
		@company = Company.new
	end

	# Create action saves the company into database
	def create
		@company = Company.new(company_params)
		if @company.save
			flash[:notice] = "Successfully created company!"
			redirect_to company_path(@company)
		else
			flash[:alert] = "Error creating new company!"
			render :new
		end
	end

	# Edit action retrives the company and renders the edit page
	def edit
	end

	# Update action updates the company with the new information
	def update
		if @company.update_attributes(company_params)
			flash[:notice] = "Successfully updated company!"
			redirect_to company_path(@company)
		else
			flash[:alert] = "Error updating company!"
			render :edit
		end
	end

	# The show action renders the individual company after retrieving the the id
	def show
	end

	# The destroy action removes the company permanently from the database
	def destroy
		if @company.destroy
			flash[:notice] = "Successfully deleted company!"
			redirect_to companies_path
		else
			flash[:alert] = "Error updating company!"
		end
	end

	private

	def company_params
		params.require(:company).permit(:name, :address, :city, :state, :zip, :country)
	end

	def find_company
		@company = Company.find(params[:id])
	end
end
