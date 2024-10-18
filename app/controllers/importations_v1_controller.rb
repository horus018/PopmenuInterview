require "debug"

class ImportationsV1Controller < ApplicationController
  def import
    if params[:file].present?
      logs = ImportService.import_from_json(params[:file])
      render json: { status: "success", logs: logs }, status: :ok
      return
    end

    render json: { status: "error", message: "No file provided" }, status: :unprocessable_entity

  rescue JSON::ParserError
    head :unprocessable_entity
  rescue StandardError => error
    head :internal_server_error
    p error
  end
end
