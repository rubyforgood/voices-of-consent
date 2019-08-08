require 'rails_helper'

RSpec.describe BoxPolicy do
  let(:user) { User.create!(email: 'test@test.com', password: 'super secret') }

  describe '#can_design?' do
    it 'blocks a user without the design permission' do
      policy = BoxPolicy.new(user, Box.new)
      refute policy.can_design?
    end
    it 'allows a user with the design permission' do
      UserPermission.create!(user: user, permission: Permission::BOX_DESIGNER)
      policy = BoxPolicy.new(user, Box.new)
      assert policy.can_design?
    end
  end

  describe 'DesignScope' do
    let(:scope_mock) { double('Box') }
    it 'will resolve to #none without the design permission' do
      expect(Box).to receive(:all).and_return(scope_mock)
      expect(scope_mock).to receive(:none).and_return([])
      scope = BoxPolicy::DesignScope.new(user, Box.all)
      expect(scope.resolve).to eq []
    end

    it 'will resolve to user-designed or undesigned boxes the design permission' do
      UserPermission.create!(user: user, permission: Permission::BOX_DESIGNER)
      expect(Box).to receive(:all).and_return(scope_mock)
      result = [Box.new]
      expect(scope_mock).to receive(:where).with(designed_by_id: [user, nil]).and_return(result)
      scope = BoxPolicy::DesignScope.new(user, Box.all)
      expect(scope.resolve).to eq result
    end
  end

  describe '#can_ship?' do
    it 'blocks a user without the shipping permission' do
      policy = BoxPolicy.new(user, Box.new)
      refute policy.can_ship?
    end
    it 'allows a user with the shipping permission' do
      UserPermission.create!(user: user, permission: Permission::SHIPPER)
      policy = BoxPolicy.new(user, Box.new)
      assert policy.can_ship?
    end
  end

  describe 'ShipmentScope' do
    let(:scope_mock) { double('Box') }
    it 'will resolve to #none without the shipping permission' do
      expect(Box).to receive(:all).and_return(scope_mock)
      expect(scope_mock).to receive(:none).and_return([])
      scope = BoxPolicy::ShipmentScope.new(user, Box.all)
      expect(scope.resolve).to eq []
    end

    it 'will resolve to user-designed or undesigned boxes the shipping permission' do
      UserPermission.create!(user: user, permission: Permission::SHIPPER)
      expect(Box).to receive(:all).and_return(scope_mock)
      result = [Box.new]
      expect(scope_mock).to receive(:where).with(shipped_by_id: [user, nil]).and_return(result)
      scope = BoxPolicy::ShipmentScope.new(user, Box.all)
      expect(scope.resolve).to eq result
    end
  end
end
