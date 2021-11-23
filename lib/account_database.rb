# frozen_string_literal: true

class AccountDatabase
  def initialize
    @account = []
  end

  def add_transaction(unix_time:, credit: 0, debit: 0, balance:)
    @account << { unix_time: unix_time, credit: credit, debit: debit, balance: balance }
  end

  def all_transactions
    account
  end

  def currant_balance
    account.last[:balance]
  end

  protected

  attr_reader :account
end
