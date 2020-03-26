# frozen_string_literal: true

class AutoEmailHandler
  include DeliverNowWithErrorHandling

  def initialize(recipient_type, object, current_user)
    @recipient_type = recipient_type
    @object = object
    @object_aasm_status = object.aasm_state
    @current_user = current_user
    @mailer_klass = nil
    @mailer_action = nil
    @permission_name = nil
    @recipients =
      if recipient_type == 'requester'
        [object.requester]
      else
        get_solicitation_recipients
      end
    @queued_autoemails = []

    send_relevant_messages
  end

  def send_relevant_messages
    set_mailer_klass
    set_mailer_mailer_action_and_permission
    generate_email_queue
    send_emails_and_log
  end

  ######

  def get_solicitation_recipients
    User.includes(:volunteer).where(volunteers: { ok_to_email: true })
        .permission(@permission_name)
  end

  def set_mailer_klass
    @mailer_klass =
      @recipient_type.include?('requester') ? RequesterMailer : VolunteerMailer
  end

  def set_mailer_mailer_action_and_permission
    if @recipient_type == 'requester' && @object_aasm_status == 'requested'
      @mailer_action = 'box_request_confirmation_email'
      @permission = nil # n/a if going to requester
    elsif @recipient_type == 'volunteer' && @object_aasm_status == 'requested'
      @mailer_action = 'review_solicitation_email'
      @permission = Permission::REQUEST_REVIEWER
    elsif @object_aasm_status == 'reviewed'
      @mailer_action = 'design_solicitation_email'
      @permission = Permission::BOX_DESIGNER
    elsif @object_aasm_status == 'designed' && @object.requires_research? &&
          @object.research_completed?
      @mailer_action = 'assembly_solicitation_email'
      @permission = Permission::BOX_ASSEMBLER
    elsif @object_aasm_status == 'designed' && @object.requires_research? &&
          !@object.research_completed?
      @mailer_action = 'research_solicitation_email'
      @permission = Permission::BOX_ITEM_RESEARCHER
    elsif @object_aasm_status == 'assembled'
      @mailer_action = 'shipping_solicitation_email'
      @permission = Permission::BOX_SHIPPER
    elsif @recipient_type == 'volunteer' && @object_aasm_status == 'shipped'
      @mailer_action = 'shipping_confirmation_email'
      @permission = Permission::REQUEST_REVIEWER
    elsif @recipient_type == 'requester' && @object_aasm_status == 'shipped'
      @mailer_action = 'shipping_confirmation_email'
      @permission = nil # n/a if going to requester
    else
      raise 'ERROR -- unknown aasm state'
    end
  end

  def generate_email_queue
    @recipients.uniq.each do |recipient|
      autoemail = @mailer_klass.public_send(@mailer_action, recipient, @object)
      @queued_autoemails << autoemail
    end
  end

  def send_emails_and_log
    @queued_autoemails.each do |email_object|
      sent_email = send_email(email_object)
      recipient =
        if @recipients.length == 1
          @recipients.first
        else
          @recipients.where(email: email_object.to).last
        end
      message_log =
        MessageLog.log_autoemail(
          email_object,
          @current_user || User.first,
          @object,
          @mailer_action,
          @current_user
        ) # store the email that was sent above as a MessageLog
    end
  end

  def send_email(email_object)
    deliver_now_with_error_handling(email_object, @mailer_action)
  end
end
