require 'rails_helper'

describe User do
  after do
    described_class.delete_all
  end

  describe '#create' do
    context 'with valid params' do
      let(:params) { { email: 'foo@mail.com', password: '12345678' } }

      it 'returns created user' do
        user = described_class.create!(params)
        expect(user.id).not_to eq nil
      end
    end

    context 'with invalid params' do
      let(:without_email) { { password: '12345678' } }
      let(:without_password) { { email: 'foo@mail.com' } }

      it 'validates presence of email attribute' do
        expect{described_class.create!(without_email)}.to raise_error ActiveRecord::RecordInvalid
      end

      it 'validates presence of password attribute' do
        expect{described_class.create!(without_password)}.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
