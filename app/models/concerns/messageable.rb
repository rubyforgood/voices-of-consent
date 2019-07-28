module Messageable
    extend ActiveSupport::Concern
    included do
      has_many :message_logs, :as => :messageable
    end
end