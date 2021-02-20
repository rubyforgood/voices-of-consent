module Feedbacks
  class VolunteersController < UnauthenticatedController
    def new
      @feedback = Feedbacks::Volunteer.new
    end
  end
end
