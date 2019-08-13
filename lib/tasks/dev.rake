namespace :dev do
  file "config/database.yml" do
    puts "** Database config not present. Creating one!"
    FileUtils.copy_file "config/database.yml.example", "config/database.yml"
  end

  desc "setup your development environment"
  task setup: ["config/database.yml", "db:setup"]
end