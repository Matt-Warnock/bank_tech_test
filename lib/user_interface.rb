# frozen_string_literal: true

class UserInterface
  DEPOSIT = 'Enter amount you wish to deposit: '
  MENU_OPTION = 'Choose an option: '
  WITHDRAWAL = 'Enter amount you wish to withdraw: '
  VALID_OPTION = /^[1-4]$/.freeze
  VALID_MONEY_AMOUNT = /^\d+(.\d{2})?$/.freeze

  def initialize(input, output, options)
    @input = input
    @output = output
    @options = options
  end

  def menu_choice
    output.puts build_menu
    prompt_valid_input(MENU_OPTION, VALID_OPTION)
  end

  def prompt_amount_for(prompt)
    prompt_valid_input(prompt, VALID_MONEY_AMOUNT)
  end

  def print_statement(statement)
    print_statement_header
    output.puts build_statement_table(statement).join("\n")
  end

  def over_transaction_limit
    output.puts 'deposit amount too high'
  end

  def insufficient_funds
    output.puts 'you have insufficient funds available'
  end

  private

  attr_reader :input, :output, :options

  def build_statement_table(statement)
    statement.reverse.each_with_object([]) do |trans, table|
      table << "#{unix_time_to_s(trans[:unix_time])} || "\
                  "#{money_format(trans[:credit])} || "\
                  "#{money_format(trans[:debit])} || "\
                  "#{money_format(trans[:balance])}"
    end
  end

  def money_format(number)
    number.zero? ? '' : format('%<money>.2f', money: number)
  end

  def unix_time_to_s(unix_time)
    Time.at(unix_time).strftime('%d/%m/%Y')
  end

  def print_statement_header
    output.puts 'date || credit || debit || balance'
  end

  def build_menu
    menu = ''
    options.each_index do |index|
      menu += "#{index + 1}. #{options[index]}\n"
    end
    menu
  end

  def prompt_valid_input(prompt, validation)
    output.puts prompt
    valid_input { |user_input| user_input.match?(validation) }
  end

  def valid_input
    loop do
      user_input = input.gets.chomp
      break user_input if yield user_input

      invalid_number_message
    end
  end

  def invalid_number_message
    output.puts 'Please enter a valid number'
  end
end
