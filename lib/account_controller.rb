# frozen_string_literal: true

class AccountController
  def initialize(actions, user_interface)
    @actions = actions
    @user_interface = user_interface
  end

  def start
    loop do
      user_choice = @user_interface.menu_choice

      @actions[user_choice.to_i - 1].run
      break if user_choice == '4'
    end
  end
end
