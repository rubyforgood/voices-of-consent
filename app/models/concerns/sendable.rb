# frozen_string_literal: true

module Sendable
  extend ActiveSupport::Concern
  included { has_many :message_logs, as: :sendable }
end
