require 'player_factory'
require 'human_player'

class CommandLinePlayerFactory
  def create_players(player_options, command_line_ui = nil)
    if player_options == PlayerOptions::HUMAN_VS_HUMAN
      {
        PlayerSymbols::X => HumanPlayer.new(PlayerSymbols::X, command_line_ui),
        PlayerSymbols::O => HumanPlayer.new(PlayerSymbols::O, command_line_ui)
      }
    elsif player_options == PlayerOptions::HUMAN_VS_AI
      {
        PlayerSymbols::X => HumanPlayer.new(PlayerSymbols::X, command_line_ui),
        PlayerSymbols::O => AiPlayer.new(PlayerSymbols::O)
      }
    else
      {
        PlayerSymbols::X => AiPlayer.new(PlayerSymbols::X),
        PlayerSymbols::O => HumanPlayer.new(PlayerSymbols::O, command_line_ui)
      }
    end
  end
end

