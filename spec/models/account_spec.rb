require 'rails_helper'

describe Account do
  let(:user) { User.create({email: 'foo@mail.com', password: '12345678'})  }
  let(:params) { { 'name' => 'Foo', 'user_id' => user.id, 'balance' => 9.99 } }
  let(:account) { Account.create(params) }

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
    let(:user_recipient) { User.create({email: 'bar@mail.com', password: '12345678'})  }
    let(:params_recipient) { { 'name' => 'Foo', 'user_id' => user_recipient.id, 'balance' => 0.00 } }
    let(:recipient) { described_class.create(params_recipient) }

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
