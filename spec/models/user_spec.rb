require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:appointments).dependent(:destroy) }
  it { should have_many(:inverse_appointments) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(20) }

  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
