# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MeetingTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/meeting_types').to route_to('meeting_types#index')
    end

    it 'routes to #new' do
      expect(get: '/meeting_types/new').to route_to('meeting_types#new')
    end

    it 'routes to #show' do
      expect(get: '/meeting_types/1').to route_to('meeting_types#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/meeting_types/1/edit').to route_to('meeting_types#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/meeting_types').to route_to('meeting_types#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/meeting_types/1').to route_to('meeting_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/meeting_types/1').to route_to('meeting_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/meeting_types/1').to route_to('meeting_types#destroy', id: '1')
    end
  end
end
