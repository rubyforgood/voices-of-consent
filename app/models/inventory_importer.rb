# frozen_string_literal: true

require 'csv'

class InventoryImporter
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def perform
    return Results.new(error_message: 'File path invalid or missing') unless data

    succeeded, errored =
      CSV.parse(data, headers: true, converters: :numeric).map do |row|
        upsert_tally(row)
      end.partition { |r| r.is_a?(InventoryTally) }

    Results.new(succeeded: succeeded, errored: errored)
  rescue CSV::MalformedCSVError => e
    Results.new(error_message: "Malformed CSV: #{e.message}")
  end

  class Results
    attr_reader :succeeded, :errored, :error_message

    def initialize(succeeded: [], errored: [], error_message: nil)
      @succeeded = succeeded # collection of inventory_tally objects
      @errored = errored # collection of arrays representing failed CSV rows
      @error_message = error_message
    end
  end

  private

  def data
    @data ||=
      begin
        File.read(file_path)
      rescue Errno::ENOENT
        # the file path may be invalid, or the tempfile may have already been destroyed
        # in which case, just return empty data
        nil
      end
  end

  def upsert_tally(row)
    location =
      Location.where('lower(name) = ?', row['location_name'].downcase)
              .first_or_create(
                name: row['location_name'], location_type: row['location_type']
              )

    inventory_type =
      InventoryType.where(
        'lower(name) = ?',
        row['inventory_type_name'].downcase
      ).first_or_create(name: row['inventory_type_name'])

    tally =
      InventoryTally.where(inventory_type: inventory_type).where(
        storage_location: location
      ).first_or_create

    tally.inventory_adjustments.create(
      adjustment_quantity: row['quantity'].to_i
    )

    tally
  rescue StandardError
    # If a row fails to update, return the csv data to allow for debugging
    row.fields
  end
end
