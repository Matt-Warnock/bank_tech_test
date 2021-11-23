# frozen_string_literal: true

require 'user_interface'

RSpec.describe UserInterface do
  let(:output) { StringIO.new }
  let(:options) { ['Deposit', 'Withdrawal', 'Account Statment', 'Exit'] }

  describe '#menu_choice' do
    let(:user_interface) { described_class.new(valid_choice, output, options) }
    let(:valid_choice) { StringIO.new("1\n") }

    it 'prints all app options' do
      user_interface.menu_choice

      expect(output.string).to include "\
1. Deposit
2. Withdrawal
3. Account Statment
4. Exit\n"
    end

    it 'prompts user to enter an option' do
      user_interface.menu_choice

      expect(output.string).to include 'Choose an option: '
    end

    it 'returns a user choice' do
      user_choice = user_interface.menu_choice

      expect(user_choice).to eq '1'
    end

    it 'only accepts a vaild choice' do
      invalid_choice = StringIO.new("5\n1\n")
      user_interface = described_class.new(invalid_choice, output, options)

      user_interface.menu_choice

      expect(output.string).to include 'Please enter a valid number'
    end
  end

  describe '#prompt_amount_for' do
    let(:user_deposit) { StringIO.new("1000\n") }
    let(:user_interface) { described_class.new(user_deposit, output, options) }
    let(:prompt) { described_class::DEPOSIT }

    it 'prompts user with prompt passed' do
      user_interface.prompt_amount_for(prompt)

      expect(output.string).to include prompt
    end

    it 'returns user amount entered' do
      user_amount = user_interface.prompt_amount_for(prompt)

      expect(user_amount).to eq '1000'
    end

    it 'accepts pence desimal point' do
      user_deposit = StringIO.new('34.95')
      user_interface = described_class.new(user_deposit, output, options)

      user_amount = user_interface.prompt_amount_for(prompt)

      expect(user_amount).to eq '34.95'
    end

    it 'only accepts valid numbers' do
      invalid_deposit = StringIO.new("Twenty-two pounds\n500\n")
      user_interface = described_class.new(invalid_deposit, output, options)

      user_interface.prompt_amount_for(prompt)

      expect(output.string).to include 'Please enter a valid number'
    end
  end

  describe '#print_statement' do
    it 'prints account statement' do
      input = StringIO.new("1\n")
      user_interface = described_class.new(input, output, options)

      user_interface.print_statement(statement)

      expect(output.string).to eq "\
date || credit || debit || balance
14/01/2023 ||  || 500.00 || 2500.00
13/01/2023 || 2000.00 ||  || 3000.00
10/01/2023 || 1000.00 ||  || 1000.00\n"
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
