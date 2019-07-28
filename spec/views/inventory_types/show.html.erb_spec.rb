require 'rails_helper'

RSpec.describe "inventory_types/show", type: :view do
  before(:each) do
    @inventory_type = assign(:inventory_type, InventoryType.create!(
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
