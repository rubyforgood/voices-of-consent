# frozen_string_literal: true

class BoxRequestTriageService
  attr_reader :box_request,
              :box_request_attribute,
              :payload,
              :abuse_types_response,
              :params

  def initialize(
    box_request,
    box_request_attribute,
    payload,
    abuse_types_response = [],
    params = {}
  )
    @box_request = box_request
    @box_request_attribute = box_request_attribute
    @payload = payload
    @abuse_types_response = abuse_types_response
    @params = params
  end

  def run
    if box_request_attribute == :abuse_types
      abuse_types =
        if abuse_types_response.try(:include?, 'All of the Above')
          params[:abuseTypeOptions] - ['All of the Above'] # pull from original option set
        else
          abuse_types_response
        end

      abuse_types.each { |abuse_type| box_request.tag_list << abuse_type } # prepopulate tags
    elsif box_request_attribute == :is_safe
      box_request.tag_list <<
        if YAML.safe_load(payload[box_request_attribute].to_s)
          'safe'
        else
          'NOT SAFE'
        end
    elsif box_request_attribute == :is_underage
      box_request.tag_list <<
        if YAML.safe_load(payload[box_request_attribute].to_s)
          '12+'
        else
          'UNDERAGE'
        end
    elsif box_request_attribute == :is_interested_in_counseling_services
      box_request.tag_list << 'counseling' if YAML.safe_load(payload[box_request_attribute].to_s)
    elsif box_request_attribute == :is_interested_in_health_services
      if YAML.safe_load(payload[box_request_attribute].to_s)
        box_request.tag_list << 'health_services'
      end
    end
  end
end
