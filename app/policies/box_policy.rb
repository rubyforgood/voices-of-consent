## BoxPolicy
# This defines permission and scopes for box permissions
# We may want to break these policies out into different objects, especially if we double-down on form objects for each of the controllers
# And so we'd have a BoxDesignController that passes to a BoxDesignForm that is guarded by a BoxDesignPolicy
# But for now, I'm putting everything in BoxPolicy until that gets to unwieldy or someone suggests it's time to switch

class BoxPolicy
  attr_reader :user, :box

  def initialize(user, box)
    @user, @box = user, box
  end

  class DesignScope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user, @scope = user, scope
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
    !!Permission.find_by(user: user, role: 'box designer')
  end
end
