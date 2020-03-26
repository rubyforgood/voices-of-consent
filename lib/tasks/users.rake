# frozen_string_literal: true

namespace :users do
  task create: :environment do
    unless ENV['EMAIL']
      puts 'ERROR: include an EMAIL= environment variable'
      exit 1
    end

    email = ENV['EMAIL']
    passwd = SecureRandom.hex(12)

    user = User.create! email: email,
                        password: passwd,
                        password_confirmation: passwd

    puts "CREATED USER #{user.id} WITH"
    puts "  email: #{user.email}"
    puts "  pass:  #{passwd}"
  end
end
