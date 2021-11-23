# frozen_string_literal: true

require 'account_database'
require 'depositer'
require 'user_interface'

RSpec.describe Depositer do
  let(:account) { AccountDatabase.new }
  let(:output) { StringIO.new }
  let(:deposit_amount) { 1106.95 }

  describe '#run' do
    it 'prints prompt for amount to deposit' do
      depositer_initialize.run

      expect(output.string).to include UserInterface::DEPOSIT
    end

    it 'adds transaction to account' do
      expect { depositer_initialize.run }
        .to change { account.all_transactions.count }.from(0).to(1)
    end

    it 'add deposits amount to balance' do
      expect { depositer_initialize.run }
        .to change { account.currant_balance }.from(0).to(deposit_amount)
    end

    it 'adds currant time to the transaction' do
      today = Time.utc(2023, 1, 10, 18, 24, 38)
      allow(Time).to receive(:now).and_return(today)

      depositer_initialize.run

      transaction_time = account.all_transactions.last[:unix_time]

      expect(transaction_time).to eq today.to_i
    end

    context 'when deposit amount is too high' do
      let(:deposit_amount) { 500_001 }

      it 'prints message to user' do
        depositer_initialize.run

        expect(output.string).to include 'deposit amount too high'
      end

      it 'does not deposit amount' do
        expect { depositer_initialize.run }
          .not_to(change { account.all_transactions.count })
      end
    end
  end

  def depositer_initialize
    options = ['Deposit', 'Withdrawal', 'Account Statment', 'Exit']
    user_interface = UserInterface.new(StringIO.new("#{deposit_amount}\n"), output, options)

    Depositer.new(account, user_interface)
  end
end
