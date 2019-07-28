require "rails_helper"

RSpec.describe InventoryTalliesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/inventory_tallies").to route_to("inventory_tallies#index")
    end

    it "routes to #new" do
      expect(:get => "/inventory_tallies/new").to route_to("inventory_tallies#new")
    end

    it "routes to #show" do
      expect(:get => "/inventory_tallies/1").to route_to("inventory_tallies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/inventory_tallies/1/edit").to route_to("inventory_tallies#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/inventory_tallies").to route_to("inventory_tallies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/inventory_tallies/1").to route_to("inventory_tallies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/inventory_tallies/1").to route_to("inventory_tallies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/inventory_tallies/1").to route_to("inventory_tallies#destroy", :id => "1")
    end
  end
end
