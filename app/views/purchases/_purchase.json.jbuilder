# frozen_string_literal: true

json.extract! purchase,
              :id,
              :location_id,
              :total_price,
              :purchased_by_id,
              :reimbursed_by_id,
              :reimbursement_check_number,
              :reimbursement_status,
              :created_at,
              :updated_at
json.url purchase_url(purchase, format: :json)
