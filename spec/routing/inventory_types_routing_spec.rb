# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/inventory_types').to route_to('inventory_types#index')
    end

    it 'routes to #new' do
      expect(get: '/inventory_types/new').to route_to('inventory_types#new')
    end

    it 'routes to #show' do
      expect(get: '/inventory_types/1').to route_to('inventory_types#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/inventory_types/1/edit').to route_to('inventory_types#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/inventory_types').to route_to('inventory_types#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/inventory_types/1').to route_to('inventory_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/inventory_types/1').to route_to('inventory_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/inventory_types/1').to route_to('inventory_types#destroy', id: '1')
    end
  end
end
