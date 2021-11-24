# frozen_string_literal: true

class AccountController
  def initialize(actions, user_interface)
    @actions = actions
    @user_interface = user_interface
  end

  def start
    @user_interface.menu_choice
  end
end
