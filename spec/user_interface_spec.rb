# frozen_string_literal: true

require 'user_interface'

RSpec.describe UserInterface do
  let(:valid_choice) { StringIO.new("1\n") }
  let(:output) { StringIO.new }
  let(:options) { ['Deposit', 'Withdrawal', 'Account Statment', 'Exit'] }
  let(:user_interface) { described_class.new(valid_choice, output, options) }

  describe '#menu_choice' do
    it 'prints all app options' do
      user_interface.menu_choice

      expect(output.string).to include "1. #{options[0]}
2. #{options[1]}
3. #{options[2]}
4. #{options[3]}\n"
    end

    it 'prompts user to enter an option' do
      user_interface.menu_choice

      expect(output.string).to include 'Choose an option: '
    end

    it 'returns a user choice' do
      user_choice = user_interface.menu_choice

      expect(user_choice).to eq 1
    end

    it 'only accepts a vaild choice' do
      invalid_choice = StringIO.new("5\n1\n")
      user_interface = described_class.new(invalid_choice, output, options)

      user_interface.menu_choice

      expect(output.string).to include 'Please enter a valid number'
    end
  end

  describe '#prompt_deposit' do
    let(:user_deposit) { StringIO.new("1000\n") }
    let(:user_interface) { described_class.new(user_deposit, output, options) }

    it 'prompts user for a deposit amount' do
      user_interface.prompt_deposit

      expect(output.string).to include 'Enter amount you wish to deposit: '
    end

    it 'returns user amount entered' do
      user_amount = user_interface.prompt_deposit

      expect(user_amount).to eq 1000
    end

    it 'accepts pence desimal point' do
      user_deposit = StringIO.new('34.95')
      user_interface = described_class.new(user_deposit, output, options)

      user_amount = user_interface.prompt_deposit

      expect(user_amount).to eq 34.95
    end

    it 'only accepts valid numbers' do
      invalid_deposit = StringIO.new("Twenty-two pounds\n500\n")
      user_interface = described_class.new(invalid_deposit, output, options)

      user_interface.prompt_deposit

      expect(output.string).to include 'Please enter a valid number'
    end
  end
end
