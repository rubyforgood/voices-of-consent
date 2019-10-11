require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  let(:valid_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone: "",
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip,
      county: Faker::Address.community,
      marketing_vector: "friends",
      why_volunteer: "to help others",
      ok_to_email: true,
      ok_to_call: true,
      ok_to_mail: true,
      ok_to_text: true,
      underage: false,
      university_location: Location.create!(
        name: 'College', street_address: '1', city: 'Testburgh',
        state: 'PA', zip: 12345, location_type: :university
      )
    }
  end

  it 'is valid with valid attributes' do
    expect(Volunteer.new(valid_attributes)).to be_valid
  end

  it 'validates required columns' do
    required_attributes = Volunteer.validators.select do |v|
      v.is_a?(ActiveRecord::Validations::PresenceValidator)
    end.flat_map(&:attributes)

    required_attributes.each do |attribute|
      atts = valid_attributes.except(attribute)
      expect(Volunteer.new(atts)).to_not be_valid
    end
  end

  it 'validates presence columns' do
    required_attributes = Volunteer.validators.select do |v|
      v.is_a?(ActiveRecord::Validations::PresenceValidator)
    end.flat_map(&:attributes)

    required_attributes.each do |attribute|
      atts = valid_attributes.except(attribute)
      expect(Volunteer.new(atts)).to_not be_valid
    end
  end

  it 'validates inclusion columns' do
    constrained_attributes = Volunteer.validators.select do |v|
      v.is_a?(ActiveModel::Validations::InclusionValidator)
    end.flat_map(&:attributes)

    constrained_attributes.each do |attribute|
      atts = valid_attributes.except(attribute)
      expect(Volunteer.new(atts)).to_not be_valid
    end
  end

  it 'has #name method' do
    volunteer = Volunteer.create(valid_attributes)
    expected_full_name = "#{volunteer.first_name} #{volunteer.last_name}"
    expect(volunteer.name).to eq(expected_full_name)
  end
end
