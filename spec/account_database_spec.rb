# frozen_string_literal: true

require 'account_database'

RSpec.describe AccountDatabase do
  let(:account_database) { described_class.new }
  let(:initial_balance) { 1000.00 }
  let(:unix_time) { 1_673_375_078 }

  describe '#add_transaction' do
    it 'adds a credit transaction to account' do
      account_database.add_transaction(
        unix_time: unix_time,
        credit: 1000.00,
        balance: initial_balance
      )

      expect(account_database.all_transactions).to eq([credit_transaction])
    end

    it 'adds a debit transaction to account' do
      account_database.add_transaction(
        unix_time: unix_time,
        debit: 500.00,
        balance: initial_balance
      )

      expect(account_database.all_transactions).to eq([debit_transaction])
    end

    it 'adds multiple transactions to account' do
      create_transaction(credit: 1000, balance: initial_balance)
      create_transaction(debit: 500, balance: initial_balance)

      expect(account_database.all_transactions)
        .to eq([credit_transaction, debit_transaction])
    end
  end

  describe '#currant_balance' do
    it 'returns the last transaction balance' do
      last_transaction_balance = 2000.00
      create_transaction(credit: 500, balance: 1500)
      create_transaction(credit: 500, balance: last_transaction_balance)

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
    { unix_time: unix_time, credit: 1000.00, debit: 0, balance: initial_balance }
  end

  def debit_transaction
    { unix_time: unix_time, credit: 0, debit: 500.00, balance: initial_balance }
  end

  def create_transaction(debit: 0, credit: 0, balance: 0)
    account_database.add_transaction(
      unix_time: unix_time,
      credit: credit,
      debit: debit,
      balance: balance
    )
  end
end
