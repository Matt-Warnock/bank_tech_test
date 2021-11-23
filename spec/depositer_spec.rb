# frozen_string_literal: true

require 'account_database'
require 'depositer'
require 'user_interface'

RSpec.describe Depositer do
  let(:account) { AccountDatabase.new }
  let(:output) { StringIO.new }

  describe '#run' do
    it 'prints prompt for amount to deposit' do
      depositer_initialize("1106.95\n").run

      expect(output.string).to include UserInterface::DEPOSIT
    end

    it 'deposits amount into account' do
      depositer_initialize("1106.95\n").run

      expect(account.currant_balance).to eq 1106.95
    end
  end

  def depositer_initialize(input)
    options = ['Deposit', 'Withdrawal', 'Account Statment', 'Exit']
    user_interface = UserInterface.new(StringIO.new(input), output, options)

    Depositer.new(account, user_interface)
  end
end
