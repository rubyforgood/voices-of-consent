# frozen_string_literal: true

## BoxPolicy
# This defines permission and scopes for box permissions
# We may want to break these policies out into different objects, especially if we double-down on form objects for each of the controllers
# And so we'd have a BoxDesignController that passes to a BoxDesignForm that is guarded by a BoxDesignPolicy
# But for now, I'm putting everything in BoxPolicy until that gets to unwieldy or someone suggests it's time to switch

class BoxPolicy
  attr_reader :user, :subject

  def initialize(user, subject = nil)
    @user = user
    @subject = subject
  end

  class DesignScope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if BoxPolicy.new(user, scope).can_design?
        scope.where(designed_by_id: [user, nil])
      else
        scope.none
      end
    end
  end

  def can_design?
    !!UserPermission.find_by(user: user, permission: Permission::BOX_DESIGNER)
  end

  class ReviewScope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if BoxPolicy.new(user, scope).can_review_box_request?
        scope.where('reviewed_by_id = ? OR reviewed_by_id IS NULL', user.id)
      end
    end
  end

  def can_review_box_request?
    !!UserPermission.find_by(
      user: user, permission: Permission::REQUEST_REVIEWER
    )
  end

  class AssemblyScope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if BoxPolicy.new(user, scope).can_design?
        scope.where(designed_by_id: [user, nil])
      else
        scope.none
      end
    end
  end

  def can_assemble?
    !!UserPermission.find_by(user: user, permission: Permission::BOX_ASSEMBLER)
  end

  class ShipmentScope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if BoxPolicy.new(user, scope).can_ship?
        scope.where(shipped_by_id: [user, nil])
      else
        scope.none
      end
    end
  end

  def can_ship?
    !!UserPermission.find_by(user: user, permission: Permission::SHIPPER)
  end
end
