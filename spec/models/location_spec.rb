require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:valid_attributes) do {
    name: 'University of Pittsburgh', street_address: '4200 Fifth Ave',
    city: 'Pittsburgh', state: 'PA', zip: 15260, location_type: :university }
  end

  it 'is valid with valid attributes' do
    expect(Location.new(valid_attributes)).to be_valid
  end

  it 'enforces location_type enum' do
    attributes = valid_attributes.merge(location_type: :solar_system)
    expect { Location.new(attributes) }.to raise_error ArgumentError
  end

  it 'returns locations by type' do
    location = Location.create(valid_attributes)
    expect(Location.university).to include(location)
  end
end
