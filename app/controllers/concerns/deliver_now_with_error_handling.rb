# frozen_string_literal: true

module DeliverNowWithErrorHandling
  extend ActiveSupport::Concern

  def deliver_now_with_error_handling(autoemail, log_message = nil)
    @delivery_status = 'success'
    begin
      autoemail.deliver_now
    rescue StandardError => e
      @delivery_status = "FAILED #{e}"
      Rails.logger.info(
        "=============BEGIN ERROR/PROBLEM WITH EMAIL DELIVERY: #{log_message}================="
      )
      Rails.logger.info("============= #{e} =================")
      Rails.logger.info(
        "=============END ERROR/PROBLEM WITH EMAIL DELIVERY: #{log_message}================="
      )
    end
  end
end
