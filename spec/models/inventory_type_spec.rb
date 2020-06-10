require 'rails_helper'

RSpec.describe InventoryType, type: :model do
  it { 
    is_expected.to have_many(:box_items)
    .class_name('BoxItem'),
    foreign_key: 'inventory_type_id',
    inverse_of: :assembly_location
  }

  it { 
    is_expected.to have_many(:core_box_items)
    .class_name('CoreBoxItem'),
    foreign_key: 'inventory_type_id',
    inverse_of: :assembly_location
  }

  it { 
    is_expected.to have_many(:inventory_tallies)
    .class_name('InventoryTally'),
    foreign_key: 'inventory_type_id',
    inverse_of: :assembly_location
  }

  let!(:location) { create_list(:location, 1, location_type: "storage_unit") }
  let!(:inventory_type) { create_list(:inventory_type, 1) }

  context 'after_create' do
    subject(:create_inventory_type) { create(:inventory_type) }

    it 'creates one inventory tally for each type location pair' do
      expect { create_inventory_type }.to change { InventoryTally.count }.by 2
    end
  end
end
