# frozen_string_literal: true

## BoxPolicy
# This defines permission and scopes for box permissions
# We may want to break these policies out into different objects, especially if we double-down on form objects for each of the controllers
# And so we'd have a BoxDesignController that passes to a BoxDesignForm that is guarded by a BoxDesignPolicy
# But for now, I'm putting everything in BoxPolicy until that gets to unwieldy or someone suggests it's time to switch

class BoxRequestPolicy
  attr_reader :user, :subject

  def initialize(user, subject = nil)
    @user = user
    @subject = subject
  end

  def claim_thank_you
    @box_request = @subject
  end
end
