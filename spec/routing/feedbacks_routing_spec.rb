require 'rails_helper'

RSpec.describe Feedbacks::VolunteersController, type: :routing do
  describe 'routing for feedbacks dashboard' do
    it 'routes to #index' do
      expect(get: '/feedbacks').to route_to('feedbacks#index')
    end

    it 'routes to #show' do
      expect(get: '/feedbacks/10').to route_to('feedbacks#show', id: '10')
    end
  end

  describe 'routing for volunters feedback' do
    it 'routes to #new' do
      expect(get: '/feedbacks/volunteers/new').to route_to('feedbacks/volunteers#new')
    end

    it 'routes to #create' do
      expect(post: '/feedbacks/volunteers').to route_to('feedbacks/volunteers#create')
    end
  end
end
