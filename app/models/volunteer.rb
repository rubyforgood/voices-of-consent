# frozen_string_literal: true

class Volunteer < ApplicationRecord
  include Messageable
  include Sendable

  require 'csv'

  has_one :user
  belongs_to :university_location, class_name: 'Location', required: false

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :ok_to_email, inclusion: { in: [true, false] }
  validates :ok_to_text, inclusion: { in: [true, false] }
  validates :ok_to_call, inclusion: { in: [true, false] }
  validates :ok_to_mail, inclusion: { in: [true, false] }
  validates :underage, inclusion: { in: [true, false] }
  validate :university_location_type

  def name
    [first_name, last_name].join(' ')
  end

  def self.import_csv(file)
    CSV.foreach(Rails.root.join(file), headers: true) do |row|
     Volunteer.create!({
        id: nil,
        first_name: row[0],
        last_name: row[1],
        street_address:  row[3],
        city: row[4],
        state: row[5],
        zip: row[6],
        county: row[7],
        phone: row[8],
        university_location_id: nil, #depending on how locations are being created and used we could use Location.find(row[8].to_i).id
        graduation_year: row[10],
        ok_to_email: row[11],
        ok_to_text: row[12],
        ok_to_call: row[13],
        ok_to_mail: row[14],
        underage: row[15]
      })
      User.create({
        id: nil,
        email: row[2],
        password: "Secret!!",
        password_confirmation: "Secret!!",
        volunteer_id: Volunteer.find_by(first_name: row[0], last_name: row[1]).id
      })

      volunteer = Volunteer.find_by(first_name: row[0], last_name: row[1])
      volunteer.user.email = User.find_by(volunteer_id: volunteer.id).email
      volunteer.save!
    end
  end

  private

  def university_location_type
    return if university_location.nil? || university_location.university?

    errors.add(:university_location, 'must be a university')
  end
end
