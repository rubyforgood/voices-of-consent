# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:valid_attributes) do
    {
      name: 'University of Pittsburgh',
      street_address: '4200 Fifth Ave',
      city: 'Pittsburgh',
      state: 'PA',
      zip: 15_260,
      location_type: :university
    }
  end

  context 'with invalid attributes' do
    it 'is invalid without name' do
      expect(Location.new(valid_attributes.without(:name))).to be_invalid
    end

    it 'is invalid without location_type' do
      expect(
        Location.new(valid_attributes.without(:location_type))
      ).to be_invalid
    end
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

  it 'has volunteers' do
    location = Location.create(valid_attributes)
    volunteer = FactoryBot.create(:volunteer)
    volunteer.update!(university_location: location)
    expect(location.volunteers).to include(volunteer)
  end

  it 'location destruction preserves associated volunteers' do
    location = Location.create(valid_attributes)
    volunteer = FactoryBot.create(:volunteer)
    volunteer.update(university_location: location)
    location.destroy!
    expect(volunteer.reload.university_location).to be_nil
  end

  it do
    is_expected.to have_many(:assembled_boxes).class_name('Box'),
                   foreign_key: 'assembly_location_id', inverse_of: :assembly_location
  end
end
