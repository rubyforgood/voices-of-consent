# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :meeting
  belongs_to :user
end
