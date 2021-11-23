# frozen_string_literal: true

require 'account_database'

RSpec.describe AccountDatabase do
  let(:account_database) { described_class.new }
  let(:balance) { 1000.00 }
  let(:unix_time) { 1_673_375_078 }

  describe '#add_transaction' do
    it 'adds a credit transaction to account' do
      account_database.add_transaction(unix_time: unix_time, credit: 1000.00, balance: balance)

      expect(account_database.all_transactions).to eq([credit_transaction])
    end

    it 'adds a debit transaction to account' do
      account_database.add_transaction(unix_time: unix_time, debit: 500.00, balance: balance)

      expect(account_database.all_transactions).to eq([debit_transaction])
    end

    it 'adds multiple transactions to account' do
      add_two_transactions

      expect(account_database.all_transactions).to eq([credit_transaction, debit_transaction])
    end
  end

  describe '#currant_balance' do
    it 'returns the last transaction balance' do
      last_transaction_balance = 2000.00

      add_two_transactions
      account_database.add_transaction(
        unix_time: unix_time,
        debit: 500.00,
        balance: last_transaction_balance
      )

      result = account_database.currant_balance

      expect(result).to eq last_transaction_balance
    end

    context 'when no transactions exist' do
      it 'returns zero balance' do
        result = account_database.currant_balance

        expect(result).to eq 0
      end
    end
  end

  def credit_transaction
    { unix_time: unix_time, credit: 1000.00, debit: 0, balance: balance }
  end

  def debit_transaction
    { unix_time: unix_time, credit: 0, debit: 500.00, balance: balance }
  end

  def add_two_transactions
    account_database.add_transaction(unix_time: unix_time, credit: 1000.00, balance: balance)
    account_database.add_transaction(unix_time: unix_time, debit: 500.00, balance: balance)
  end
end
