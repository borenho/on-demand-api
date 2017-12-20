class Product < ApplicationRecord
  # Associations
  belongs_to :merchant

  # Validations
  validates_presence_of :name, :price
end
