# frozen_string_literal: true

class UserInterface
  VAID_OPTION = /^[1-4]$/.freeze
  VAILD_MONEY_AMOUNT = /^\d+(.\d{2})?$/.freeze

  def initialize(input, output)
    @input = input
    @output = output
  end

  def menu_choice(options)
    print_menu(options)
    output.puts 'Choose an option: '
    valid_input { |user_input| user_input.match?(VAID_OPTION) }
  end

  private

  attr_reader :input, :output

  def print_menu(options)
    options.each_index do |index|
      output.puts "#{index + 1}. #{options[index]}"
    end
  end

  def valid_input
    loop do
      user_input = input.gets.chomp
      break user_input.to_i if yield user_input

      output.puts 'Please enter a valid choice'
    end
  end
end
