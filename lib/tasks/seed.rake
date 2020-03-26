# frozen_string_literal: true

namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      desc "Loads the seed data from db/seeds/#{File.basename(filename)}"
      task File.basename(filename, '.rb').to_sym => :environment do
        load(filename)
        Rake::Task['db:seed'].invoke
      end
    end
  end
end
