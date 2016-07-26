class HealthCheckController < ApplicationController
  def index
    render json: {status: 'API Running!'}
  end
end
