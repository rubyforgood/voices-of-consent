# frozen_string_literal: true

class AttendancePolicy < ApplicationPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def index?
    can_volunteer_at_events?
    # false
  end

  def show?
    can_volunteer_at_events?
  end

  def create?
    can_volunteer_at_events?
  end

  def update?
    can_volunteer_at_events?
  end

  def destroy?
    can_volunteer_at_events?
  end

  def can_volunteer_at_events?
    !!UserPermission.find_by(user: user, permission: Permission::VOLUNTEER_AT_EVENTS)
  end

  class Scope < Scope
    def resolve
      if AttendancePolicy.new(user, scope).can_volunteer_at_events?
        scope.where(user_id: [user, nil])
      else
        scope.none
      end
    end
  end
end
