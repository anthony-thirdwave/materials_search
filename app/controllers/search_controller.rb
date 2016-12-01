class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @materials = []
    else
      @materials = Material.search params[:q]
    end
  end
end
