require 'rails_helper'

RSpec.describe Product, type: :model do
  # Validation Tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

  # Association Tests
  it { should belong_to(:merchant)}
end
