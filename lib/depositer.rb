# frozen_string_literal: true

require 'user_interface'

class Depositer
  def initialize(account, user_interface)
    @account = account
    @user_interface = user_interface
  end

  def run
    deposit = collect_deposit
    return user_interface.over_transaction_limit if deposit > 500_000

    new_balance = account.currant_balance + deposit

    account.add_transaction(
      unix_time: unix_time_now,
      credit: deposit,
      balance: new_balance
    )
  end

  private

  attr_reader :account, :user_interface

  def collect_deposit
    user_interface.prompt_amount_for(UserInterface::DEPOSIT).to_f
  end

  def unix_time_now
    Time.now.to_i
  end
end
