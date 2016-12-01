class PagesController < ApplicationController
  def index
    if params[:search].present?
      @materials = MaterialSearch.new(query: params[:search]).results
      @companies = []
      @materials.each do |material|
        material.companies.each do |company|
          @companies << company
        end
      end
      @companies = @companies.uniq
    else
      @materials = Material.all
      @companies = Company.all
    end
  end
end
