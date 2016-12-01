class PagesController < ApplicationController
  def index
    @companies = Company.all
    @materials = Material.all
  end
end
