class Merchant < ApplicationRecord
    # Associations
    has_many :products, dependent: :destroy

    # Validations
    validates_presence_of :name, :created_by
end
