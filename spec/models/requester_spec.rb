require 'rails_helper'

RSpec.describe Requester, :type => :model do
 it "is valid with valid attributes" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to be_valid
 end

 it "requires first_name" do
   r = Requester.new(last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires last_name" do
   r = Requester.new(first_name: "Jane", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 describe "email" do
    it "requires email" do
    r = Requester.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
    expect(r).to_not be_valid
  end

  it "requires a valid email address" do
    r = Requester.new(first_name: "Jane", last_name: "Doe", email: "janeemai.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
    expect(r).to_not be_valid
  end

  it "will accept a vaild email address" do
    r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", phone: 555-555-5555, street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
  end

 end

 it "requires street_address" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires city" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires state" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires zip" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires ok_to_text" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires ok_to_call" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires ok_to_mail" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, underage: false)
   expect(r).to_not be_valid
 end

 it "requires ok_to_email" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false)
   expect(r).to_not be_valid
 end

 it "requires underage" do
   r = Requester.new(first_name: "Jane", last_name: "Doe", email: "jane@email.com", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true)
   expect(r).to_not be_valid
 end
end
