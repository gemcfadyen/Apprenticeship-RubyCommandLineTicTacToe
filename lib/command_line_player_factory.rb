require 'player_factory'
require 'human_player'

class CommandLinePlayerFactory < PlayerFactory
  def create_human(command_line_ui, symbol)
    HumanPlayer.new(command_line_ui, symbol)
  end
end
