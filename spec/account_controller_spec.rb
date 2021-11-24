# frozen_string_literal: true

require 'account_controller'

RSpec.describe AccountController do
  let(:withdrawer) { double('withdrawer') }
  let(:user_interface) { double('user_interface', menu_choice: '2') }

  describe '#start' do
    it 'calls the user menu' do
      initialize_controller.start

      expect(user_interface).to have_received(:menu_choice)
    end
  end

  def initialize_controller
    depositer = double('depositer')
    statementer = double('statementer')
    null_action = double('null_action')
    actions = [depositer, withdrawer, statementer, null_action]

    described_class.new(actions, user_interface)
  end
end
