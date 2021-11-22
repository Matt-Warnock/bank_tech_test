# frozen_string_literal: true

require 'user_interface'

RSpec.describe UserInterface do
  let(:output) { StringIO.new }
  let(:user_interface) { described_class.new(output) }

  describe '#print_menu' do
    it 'prints all app options' do
      options = ['Deposit', 'Withdrawal', 'Account Statment', 'Exit']

      user_interface.print_menu(options)

      expect(output.string).to eq "1. #{options[0]}
2. #{options[1]}
3. #{options[2]}
4. #{options[3]}
"
    end
  end
end
