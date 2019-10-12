require 'csv'

class InventoryImporter

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def perform
    return unless data
    CSV.parse(data, headers: true) do |row|
      upsert_tally(row)
    end
  end

  private

  # TODO: maybe raise a custom error class here instead
  def data
    File.read(file_path)
  rescue Errno::ENOENT
    # the file path may be invalid, or the tempfile may have already been destroyed
    # in which case, just return empty data
    nil
  end

  def upsert_tally(row)
    return false unless row["location_name"] && row["inventory_type_name"]
    location = Location.where("lower(name) = ?", row["location_name"].downcase).first_or_create(name: row["location_name"])
    inventory_type = InventoryType.where("lower(name) = ?", row["inventory_type_name"].downcase).first_or_create(name: row["inventory_type_name"])
    tally = InventoryTally.where(inventory_type: inventory_type).where(storage_location: location).first_or_create
    tally.inventory_adjustments.create(adjustment_quantity: row["quantity"])
  end

end