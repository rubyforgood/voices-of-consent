require 'rails_helper'

RSpec.describe Volunteer, :type => :model do
  it "is valid with valid attributes" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to be_valid
  end

  it "requires a first name" do 
    v = Volunteer.new(last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires a last name" do 
    v = Volunteer.new(first_name: "Jane", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires a street address" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires a city" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires a state" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires a zip code" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires ok_to_email attribute" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires ok_to_text attribute" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires ok_to_call attribute" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false,
     ok_to_mail: true, underage: false)
    expect(v).to_not be_valid
  end

  it "requires ok_to_mail attribute" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
    underage: false)
    expect(v).to_not be_valid
  end

  it "requires underage attribute" do 
    v = Volunteer.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true)
    expect(v).to_not be_valid
  end

  it "has a user" do
    u = User.new()
    v = Volunteer.new(user: u, first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue",
     city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false,
     ok_to_mail: true, underage: false)
    expect(v).to be_valid
    expect(v.user.id).to eq(u.id)
  end
end
