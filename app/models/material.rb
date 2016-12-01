class Material < ActiveRecord::Base
  has_and_belongs_to_many :companies
  validates :section, presence: true
  validates :cat_1, presence: true
  validates :cat_2, presence: true
  include PgSearch
  multisearchable against: [:section, :cat_1, :cat_2, :cat_3]
end
