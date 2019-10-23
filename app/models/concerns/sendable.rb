module Sendable
    extend ActiveSupport::Concern
    included do
      has_many :message_logs, :as => :sendable
    end
end