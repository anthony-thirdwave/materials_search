class Company < ActiveRecord::Base
  has_and_belongs_to_many :materials
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
end
