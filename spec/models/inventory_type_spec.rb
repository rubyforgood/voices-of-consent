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

  context 'after_create' do
    context 'when location_type is storage_unit' do
      before do
        create_list(:location, 4, location_type: "storage_unit")
      end

      it 'should create a InventoryTally to each Location' do
        inventory_type = create(:inventory_type)
        expect(InventoryTally.where(inventory_type: inventory_type).count).to eq(4)
      end
    end
  end
end
