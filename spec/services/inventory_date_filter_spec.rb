require 'rails_helper'

RSpec.describe InventoryDateFilter do
  describe "calls the correct method" do
    let(:hash) {{ inventory: { start_date: Date.today.to_s, end_date: Date.today.to_s } }}
    let(:hash_expected) { { start_date: Date.today.to_s, end_date: Date.today.to_s } }

    context "params given" do
      it "#initialize" do
        expect(described_class.new(hash).params).to eq(hash)
      end

      it "#call" do
        expect(described_class.new(hash).call).to eq(hash_expected)
      end
      it "#set_value_for_inventory" do
        expect(described_class.new(hash).set_value_for_inventory(hash)).to eq(hash_expected)
      end
      it ".call" do
        expect(described_class.call(hash)).to eq(hash_expected)
      end
    end
  end
end
