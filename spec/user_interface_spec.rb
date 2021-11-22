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

      expect(output.string).to include 'Please enter a valid choice'
    end
  end
end
