# frozen_string_literal: true

class MeetingType < ApplicationRecord
  has_many :meetings
end
