require "rails_helper"

RSpec.describe BoxRequestAbuseTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/box_request_abuse_types").to route_to("box_request_abuse_types#index")
    end

    it "routes to #new" do
      expect(:get => "/box_request_abuse_types/new").to route_to("box_request_abuse_types#new")
    end

    it "routes to #show" do
      expect(:get => "/box_request_abuse_types/1").to route_to("box_request_abuse_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/box_request_abuse_types/1/edit").to route_to("box_request_abuse_types#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/box_request_abuse_types").to route_to("box_request_abuse_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/box_request_abuse_types/1").to route_to("box_request_abuse_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/box_request_abuse_types/1").to route_to("box_request_abuse_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/box_request_abuse_types/1").to route_to("box_request_abuse_types#destroy", :id => "1")
    end
  end
end
