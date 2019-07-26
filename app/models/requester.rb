class Requester < ApplicationRecord
  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :street_address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true
  validates :ok_to_email, presence:true
  validates :ok_to_text, presence:true
  validates :ok_to_call, presence:true
  validates :ok_to_mail, presence:true
  validates :underage, presence:true
end
