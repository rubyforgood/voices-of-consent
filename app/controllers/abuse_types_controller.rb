# frozen_string_literal: true

class AbuseTypesController < ApplicationController
  # GET /attendances.json
  def index
    @abuse_types = AbuseType.all
  end
end
