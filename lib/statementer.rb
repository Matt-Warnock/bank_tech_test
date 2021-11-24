# frozen_string_literal: true

class Statementer
  def initialize(account, user_interface)
    @account = account
    @user_interface = user_interface
  end

  def run
    user_interface.print_statement(account.all_transactions)
  end

  private

  attr_reader :account, :user_interface
end
