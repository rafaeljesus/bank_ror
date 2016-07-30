require 'rails_helper'

describe UsersController do
  after do
    User.delete_all
  end

  describe 'POST create' do
    let(:params) { { user: { email: 'foo@mail.com', password: '12345678' } } }

    it 'returns created user id' do
      post :create, params: params
      expect(response_body_as_json['id']).not_to eq nil
    end
  end
end
