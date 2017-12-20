require 'rails_helper'

# Test suite for the Merchant model
RSpec.describe Merchant, type: :model do
  # Validation Tests (validation and association tests are provided by the shoulda matchers gem)
  # Ensure columns name and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }

  # Association Tests
  # Ensure it has a 1;m relationship wth the Product model
  it { should have_many(:products).dependent(:destroy) }
end
