require 'rails_helper'

RSpec.describe FeedbackPolicy do
  let(:user) { create(:user, volunteer: create(:volunteer)) }

  describe '#index?' do
    it 'blocks a user that is not admin' do
      policy = FeedbackPolicy.new(user, Feedback.new)
      refute policy.index?
    end
    it 'allows admin users' do
      UserPermission.create!(user: user, permission: 'manage users')
      policy = FeedbackPolicy.new(user, Feedback.new)
      assert policy.index?
    end
  end

  describe '#show?' do
    it 'blocks a user that is not admin' do
      policy = FeedbackPolicy.new(user, Feedback.new)
      refute policy.show?
    end

    it 'allows admin users' do
      UserPermission.create!(user: user, permission: 'manage users')
      policy = FeedbackPolicy.new(user, Feedback.new)
      assert policy.show?
    end
  end
end
