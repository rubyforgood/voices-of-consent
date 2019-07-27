require "rails_helper"

RSpec.describe AttendancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/attendances").to route_to("attendances#index")
    end

    it "routes to #new" do
      expect(:get => "/attendances/new").to route_to("attendances#new")
    end

    it "routes to #show" do
      expect(:get => "/attendances/1").to route_to("attendances#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/attendances/1/edit").to route_to("attendances#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/attendances").to route_to("attendances#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/attendances/1").to route_to("attendances#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/attendances/1").to route_to("attendances#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/attendances/1").to route_to("attendances#destroy", :id => "1")
    end
  end
end
