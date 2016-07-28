require 'rails_helper'

describe Account do
  let(:user) { User.create({email: 'foo@mail.com', password: '12345678'})  }
  let(:params) { { 'name' => 'Foo', 'user_id' => user.id, 'balance' => 9.99 } }

  after do
    described_class.delete_all
  end

  describe '#open' do
    context 'with valid params' do
      it 'opens a new account' do
        opened = described_class.open(params)
        expect(opened).to eq true
      end
    end

    context 'with invalid params' do
      let(:without_name) { { user_id: '123b' } }
      let(:without_user_id) { { name: 'Foo' } }

      it 'validates presence of name attribute' do
        expect{described_class.open(without_name)}.to raise_error ActiveRecord::RecordInvalid
      end

      it 'validates presence of user_id attribute' do
        expect{described_class.open(without_user_id)}.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
