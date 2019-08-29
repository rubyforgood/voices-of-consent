class Requester < ApplicationRecord
  include Messageable

  has_many :box_requests

  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :street_address, presence:true
  validates :email, presence:true,  :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Must be a valid email address." }
  validates :phone, :format => { :with => /[0-9]{3}-[0-9]{3}-[0-9]{4}/, :message => "Must be a valid phone number in xxx-xxx-xxxx format.", :allow_blank => true }
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true
  validates :ok_to_email, inclusion: { in: [ true, false ] }
  validates :ok_to_text, inclusion: { in: [ true, false ] }
  validates :ok_to_call, inclusion: { in: [ true, false ] }
  validates :ok_to_mail, inclusion: { in: [ true, false ] }
  validates :underage, inclusion: { in: [ true, false ] }

  def name
    [first_name, last_name].join(' ')
  end
end
