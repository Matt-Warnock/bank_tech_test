# frozen_string_literal: true

require 'user_interface'

class Withdrawer
  def initialize(account, user_interface)
    @account = account
    @user_interface = user_interface
  end

  def run
    currant_balance = account.currant_balance
    return user_interface.insufficient_funds unless currant_balance.positive?

    withdrawal = collect_withdrawal
    return user_interface.insufficient_funds if withdrawal > currant_balance

    account.add_transaction(
      unix_time: unix_time_now,
      debit: withdrawal,
      balance: currant_balance - withdrawal
    )
  end

  private

  attr_reader :account, :user_interface

  def collect_withdrawal
    user_interface.prompt_amount_for(UserInterface::WITHDRAWAL).to_f
  end

  def unix_time_now
    Time.now.to_i
  end
end
