class SearchController < ApplicationController
  def search
    query = params[:q].presence || '*'
    @materials = Material.search query
    @companies = @materials.map(&:companies).flatten.uniq
  end
end
