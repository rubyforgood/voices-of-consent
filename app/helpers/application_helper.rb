# frozen_string_literal: true

module ApplicationHelper
  def heroku_link(destination_string)
    if ENV['RAILS_ENV'] == 'production' && ENV['DATABASE_URL'] == ENV['HEROKU_TEST_DB_URL']
      "https://voices-of-consent-test.herokuapp.com/#{destination_string}" # 2nd production site, aka staging
    elsif ENV['RAILS_ENV'] == 'production' && ENV['DATABASE_URL'] != ENV['HEROKU_TEST_DB_URL']
      "https://#{ENV['HEROKU_APP_NAME']}.herokuapp.com/#{destination_string}"
    else
      "/#{destination_string.gsub(%r{^/}, '')}"
    end
  end
end
