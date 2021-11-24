# frozen_string_literal: true

require 'account_database'
require 'statementer'
require 'user_interface'

RSpec.describe Statementer do
  describe '#run' do
    it 'prints the accounts statement' do
      account = instance_double(AccountDatabase, all_transactions: statement)
      user_interface = instance_double(UserInterface, print_statement: nil)

      described_class.new(account, user_interface).run

      expect(user_interface).to have_received(:print_statement).with(statement)
    end
  end
  def statement
    [
      { unix_time: 1_673_375_078, credit: 1000.00, debit: 0, balance: 1000.00 },
      { unix_time: 1_673_634_278, credit: 2000.00, debit: 0, balance: 3000.00 },
      { unix_time: 1_673_720_678, credit: 0, debit: 500.00, balance: 2500.00 }
    ]
  end
end
