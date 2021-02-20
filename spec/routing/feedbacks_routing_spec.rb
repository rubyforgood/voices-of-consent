require "rails_helper"

RSpec.describe Feedbacks::VolunteersController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/feedbacks/volunteers/new").to route_to("feedbacks/volunteers#new")
    end
  end
end
