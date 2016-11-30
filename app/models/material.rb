class Material < ActiveRecord::Base
  validates :section, presence: true
  validates :cat_1, presence: true
  validates :cat_2, presence: true
end
