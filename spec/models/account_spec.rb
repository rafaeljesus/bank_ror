require 'rails_helper'

describe Account do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user_id: user.id) }

  describe '#open' do
    context 'with valid params' do
      let(:params) { attributes_for(:account, user_id: user.id) }

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

  describe '#deposit' do
    context 'with valid params' do
      it 'deposit into account' do
        deposited = described_class.deposit(account, 9.99)
        expect(deposited).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns falsy' do
        deposited = described_class.deposit(account, 0.00)
        expect(deposited).to eq false
      end
    end
  end

  describe '#withdraw' do
    context 'with valid params' do
      it 'withdraw from account' do
        withdrawn = described_class.withdraw(account, 9.99)
        expect(withdrawn).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns falsy' do
        withdrawn = described_class.withdraw(account, 0.00)
        expect(withdrawn).to eq false
      end
    end
  end

  describe '#transfer' do
    let!(:user_recipient) { create(:user, email: 'bar@mail.com') }
    let(:params_recipient) { attributes_for(:account, user_id: user_recipient.id) }
    let!(:recipient) { create(:account, params_recipient) }

    context 'with valid params' do
      it 'transfer from one account to another account' do
        transfered = described_class.transfer(account, recipient, 9.99)
        expect(transfered).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns false' do
        transfered = described_class.transfer(account, recipient, 0.00)
        expect(transfered).to eq false
      end
    end
  end
end
