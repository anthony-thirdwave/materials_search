require 'elasticsearch/model'
class Material < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_and_belongs_to_many :companies
  validates :section, presence: true
  validates :cat_1, presence: true
  validates :cat_2, presence: true
end
Material.import force: true
