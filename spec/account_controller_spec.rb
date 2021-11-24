# frozen_string_literal: true

require 'account_controller'

RSpec.describe AccountController do
  let(:withdrawer) { spy('withdrawer') }
  let(:user_interface) { double('user_interface') }

  describe '#start' do
    context 'when user selects an action' do
      before(:each) do
        allow(user_interface).to receive(:menu_choice).and_return('2', '4')
        initialize_controller.start
      end

      it 'calls the action selected by user' do
        expect(withdrawer).to have_received(:run).once
      end

      it 'calls the user menu again' do
        expect(user_interface).to have_received(:menu_choice).twice
      end
    end

    context 'when user selects exit' do
      it 'calls the user menu once' do
        allow(user_interface).to receive(:menu_choice).and_return('4')

        initialize_controller.start

        expect(user_interface).to have_received(:menu_choice).once
      end
    end
  end

  def initialize_controller
    actions = [
      double('depositer'),
      withdrawer,
      double('statementer'),
      double('null_action', run: nil)
    ]

    described_class.new(actions, user_interface)
  end
end
