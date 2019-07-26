json.extract! box_request, :id, :summary, :question_re_current_situation, :question_re_affect, :question_re_referral_source, :question_re_if_not_self_completed, :created_at, :updated_at
json.url box_request_url(box_request, format: :json)
