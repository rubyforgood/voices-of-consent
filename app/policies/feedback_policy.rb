# frozen_string_literal: true

class FeedbackPolicy < ApplicationPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def index?
    can_view_feedbacks?
   # false
  end

  def show?
    can_view_feedbacks?
  end

  def can_view_feedbacks?
    @user.is_admin?
  end

  class Scope < Scope
    def resolve
      if FeedbackPolicy.new(user, scope).can_view_feedbacks?
        scope.all
      else
        scope.none
      end
    end
  end
end
