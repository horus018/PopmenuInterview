class RoutesController < ApplicationController
  def index
    @routes = Rails.application.routes.routes.map { |route| route.path.spec.to_s }
    render plain: @routes.join("\n")
  end
end
