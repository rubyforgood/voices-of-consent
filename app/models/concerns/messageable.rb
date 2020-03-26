# frozen_string_literal: true

module Messageable
  extend ActiveSupport::Concern
  included { has_many :message_logs, as: :messageable }
end
