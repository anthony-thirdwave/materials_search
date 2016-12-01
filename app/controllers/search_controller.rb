class SearchController < ApplicationController
  def search
    @companies = []
    if params[:q].nil?
      @materials = []
    else
      @materials = Material.search params[:q]
      @materials.each do |material|
        material.companies.each do |company|
          if !@companies.include? company
            @companies << company
          end
        end
      end
    end
  end
end
