require 'elasticsearch/model'
class Material < ActiveRecord::Base
  has_and_belongs_to_many :companies
  validates :section, presence: true
  validates :cat_1, presence: true
  validates :cat_2, presence: true

  searchkick text_start: [:cat_2]
  def search_data
    attributes.merge(
      companies_name: companies.map(&:name)
    )
  end
end
