require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:appointments).dependent(:destroy) }
  it { should have_many(:inverse_appointments) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(20) }

  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
