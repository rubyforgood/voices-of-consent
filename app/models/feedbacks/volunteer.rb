module Feedbacks
  class Volunteer < Feedback
    validates :category, :description, presence: true
    validates :category, inclusion: { in: Feedback::CATEGORIES }
  end
end
