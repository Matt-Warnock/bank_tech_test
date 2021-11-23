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
    print_menu
    prompt_valid_input(MENU_OPTION, VALID_OPTION)
  end

  def prompt_amount_for(prompt)
    prompt_valid_input(prompt, VALID_MONEY_AMOUNT)
  end

  def print_statement(statement)
    print_statement_header
    statement.reverse.each do |trans|
      output.puts "#{unix_time_to_s(trans[:unix_time])} || "\
                  "#{money_format(trans[:credit])} || "\
                  "#{money_format(trans[:debit])} || "\
                  "#{money_format(trans[:balance])}"
    end
  end

  private

  attr_reader :input, :output, :options

  def money_format(number)
    number.zero? ? '' : format('%<money>.2f', money: number)
  end

  def unix_time_to_s(unix_time)
    Time.at(unix_time).strftime('%d/%m/%Y')
  end

  def print_statement_header
    output.puts 'date || credit || debit || balance'
  end

  def print_menu
    options.each_index do |index|
      output.puts "#{index + 1}. #{options[index]}"
    end
  end

  def prompt_valid_input(prompt, validation)
    output.puts prompt
    valid_input { |user_input| user_input.match?(validation) }
  end

  def valid_input
    loop do
      user_input = input.gets.chomp
      break user_input if yield user_input

      output.puts 'Please enter a valid number'
    end
  end
end
