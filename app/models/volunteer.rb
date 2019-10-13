# frozen_string_literal: true

class Volunteer < ApplicationRecord
  include Messageable
  require 'csv'

  has_one :user

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

  def name
    [first_name, last_name].join(' ')
  end

  def self.import_csv(file)
    CSV.foreach(Rails.root.join(file), headers: true) do |row|
      Volunteer.create({
        id: nil,
        first_name: row[0],
        last_name: row[1],
        street_address:  row[2],
        city: row[3],
        state: row[4],
        zip: row[5],
        county: row[6],
        phone: row[7],
        university_location_id: nil, #depending on how locations are being created and used we could use Location.find(row[8].to_i).id
        graduation_year: row[9],
        ok_to_email: row[10],
        ok_to_text: row[11],
        ok_to_call: row[12],
        ok_to_mail: row[13],
        underage: row[14]
      })
    end
  end
end
