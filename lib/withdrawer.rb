# frozen_string_literal: true

require 'user_interface'

class Withdrawer
  def initialize(account, user_interface)
    @account = account
    @user_interface = user_interface
  end

  def run
    return user_interface.insufficient_funds unless account.currant_balance.positive?

    withdrawal = user_interface.prompt_amount_for(UserInterface::WITHDRAWAL).to_f

    new_balance = account.currant_balance - withdrawal

    account.add_transaction(
      unix_time: unix_time_now,
      debit: withdrawal,
      balance: new_balance
    )
  end

  private

  attr_reader :account, :user_interface

  def unix_time_now
    Time.now.to_i
  end
end
