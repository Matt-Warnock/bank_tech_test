# frozen_string_literal: true

require 'user_interface'

class Withdrawer
  def initialize(account, user_interface)
    @account = account
    @user_interface = user_interface
  end

  def run
    user_interface.prompt_amount_for(UserInterface::WITHDRAWAL).to_f
  end

  private

  attr_reader :user_interface
end
