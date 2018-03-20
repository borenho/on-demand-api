require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
    # Association tests
    # The User model should have a 1:m r/ship with the Merchant Model: a user can create several seller accounts
    it { should have_many(:merchants) }

    # Validation tests
    # Name, email should be present before saving to the db
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
end
