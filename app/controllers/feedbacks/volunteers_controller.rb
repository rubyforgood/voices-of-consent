module Feedbacks
  class VolunteersController < ApplicationController
    def new
      @feedback = Feedbacks::Volunteer.new
    end
  end
end
