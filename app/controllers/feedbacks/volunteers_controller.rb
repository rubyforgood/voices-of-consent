module Feedbacks
  class VolunteersController < UnauthenticatedController
    def new
      @feedback = Feedbacks::Volunteer.new
    end

    def create
      @volunteer_feedback = Feedbacks::Volunteer.new(volunteer_feedback_params)

      if @volunteer_feedback.save
        render json: { message: 'Feedback was succesfull created, thank you!' }, status: :created
      else
        render json: @volunteer_feedback.errors, status: :unprocessable_entity
      end
    end

    private

    def volunteer_feedback_params
      params.require(:feedback).permit(:category, :description)
    end
  end
end
