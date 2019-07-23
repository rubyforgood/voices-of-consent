require 'twilio-ruby'

# put your own credentials here
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token =  ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
$twilio_client = Twilio::REST::Client.new account_sid, auth_token
