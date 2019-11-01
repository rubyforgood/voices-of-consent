class InventoryImportsController < ApplicationController

  # GET /inventory_imports/new
  def new
  end

  # POST /inventory_imports
  def create
    results = InventoryImporter.new(params[:import_file]&.path).perform

    notices = []
    notices << results.error_message
    notices << "Successfully updated #{results.succeeded.count} tallies." if results.succeeded.any?
    notices << "Failed to update #{results.errored.count} tallies." if results.errored.any?

    if results.succeeded.any?
      flash[:notice] = notices.join(" ")
      redirect_to inventory_tallies_url
    else
      notices << "Please check file formatting and try again."
      flash.now[:notice] = notices.join(" ")
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def inventory_tally_params
    params.require(:inventory_import).permit(:import_file)
  end
end
