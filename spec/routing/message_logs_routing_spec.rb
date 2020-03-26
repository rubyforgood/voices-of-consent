# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageLogsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/message_logs').to route_to('message_logs#index')
    end

    it 'routes to #new' do
      expect(get: '/message_logs/new').to route_to('message_logs#new')
    end

    it 'routes to #show' do
      expect(get: '/message_logs/1').to route_to('message_logs#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/message_logs/1/edit').to route_to(
        'message_logs#edit',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/message_logs').to route_to('message_logs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/message_logs/1').to route_to('message_logs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/message_logs/1').to route_to(
        'message_logs#update',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/message_logs/1').to route_to(
        'message_logs#destroy',
        id: '1'
      )
    end
  end
end
