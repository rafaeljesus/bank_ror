require 'rails_helper'

describe HealthCheckController do
  describe 'GET health check' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
