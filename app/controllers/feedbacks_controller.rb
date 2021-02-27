# frozen_string_literal: true

class FeedbacksController < ApplicationController

  def index
    @feedbacks = policy_scope(Feedback)
    return redirect_to root_path unless policy(@feedbacks).index?
  end

  def show
    @feedback = policy_scope(Feedback).find(params[:id])
    return redirect_to root_path unless policy(@feedback).show?
  end
end
