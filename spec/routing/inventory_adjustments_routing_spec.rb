require "rails_helper"

RSpec.describe InventoryAdjustmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/inventory_adjustments").to route_to("inventory_adjustments#index")
    end

    it "routes to #new" do
      expect(:get => "/inventory_adjustments/new").to route_to("inventory_adjustments#new")
    end

    it "routes to #show" do
      expect(:get => "/inventory_adjustments/1").to route_to("inventory_adjustments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/inventory_adjustments/1/edit").to route_to("inventory_adjustments#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/inventory_adjustments").to route_to("inventory_adjustments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/inventory_adjustments/1").to route_to("inventory_adjustments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/inventory_adjustments/1").to route_to("inventory_adjustments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/inventory_adjustments/1").to route_to("inventory_adjustments#destroy", :id => "1")
    end
  end
end
