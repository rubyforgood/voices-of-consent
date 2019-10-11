# frozen_string_literal: true

class Volunteer < ApplicationRecord
  include Messageable

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

  private

  def university_location_type
    return if university_location.nil? || university_location.university?

    errors.add(:university_location, 'must be a university')
  end
end
