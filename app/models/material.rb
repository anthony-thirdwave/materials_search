require 'elasticsearch/model'
class Material < ActiveRecord::Base
  searchkick autocomplete: ['cat_2']
  has_and_belongs_to_many :companies
  validates :section, presence: true
  validates :cat_1, presence: true
  validates :cat_2, presence: true
end
