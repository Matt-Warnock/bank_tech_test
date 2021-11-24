# frozen_string_literal: true

require 'account_database'
require 'withdrawer'
require 'user_interface'

RSpec.describe Withdrawer do
  let(:account) { AccountDatabase.new }
  let(:initial_deposit) { 500 }
  let(:today) { Time.utc(2023, 1, 10, 18, 24, 38) }
  let(:output) { StringIO.new }
  let(:withdrawal_amount) { 35.95 }

  describe '#run' do
    it 'prints prompt for amount to withdraw' do
      withdrawer_initialize.run

      expect(output.string).to include UserInterface::WITHDRAWAL
    end

    xit 'adds transaction to account' do
      expect { withdrawer_initialize.run }
        .to change { account.all_transactions.count }.from(1).to(2)
    end

    xit 'takes away withdrawal amount from balance' do
      balance_after_withdrawal = initial_deposit - withdrawal_amount

      expect { withdrawer_initialize.run }
        .to change { account.currant_balance }
        .from(initial_deposit).to(balance_after_withdrawal)
    end

    xit 'adds currant time to the transaction' do
      allow(Time).to receive(:now).and_return(today)

      withdrawer_initialize.run

      transaction_time = account.all_transactions.last[:unix_time]

      expect(transaction_time).to eq today.to_i
    end

    context 'when withdrawing more than in account' do
      let(:withdrawal_amount) { initial_deposit + 1 }

      xit 'prints message to user' do
        withdrawer_initialize.run

        expect(output.string).to include 'you have insufficient funds available'
      end

      xit 'does not withdraw amount' do
        expect { withdrawer_initialize.run }
          .not_to(change { account.all_transactions.count })
      end
    end

    context 'when no balance in account' do
      let(:initial_deposit) { 0 }

      xit 'does not prompt user for withdrawal amount' do
        withdrawer_initialize.run

        expect(output.string).to_not include UserInterface::CREDIT
      end

      xit 'prints message to user' do
        withdrawer_initialize.run

        expect(output.string).to include 'you have insufficient funds available'
      end
    end
  end

  def withdrawer_initialize
    options = ['Deposit', 'Withdrawal', 'Account Statment', 'Exit']
    user_interface = UserInterface.new(StringIO.new("#{withdrawal_amount}\n"), output, options)

    add_to_account(initial_deposit)
    Withdrawer.new(account, user_interface)
  end

  def add_to_account(credit)
    account.add_transaction(unix_time: today.to_i, credit: credit, balance: credit)
  end
end
