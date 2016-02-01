require 'game'

class CommandLineApp

  def initialize(command_line_ui, board_factory, player_factory)
    @command_line_ui = command_line_ui
    @board_factory = board_factory
    @player_factory = player_factory
  end

  def start
    replay_option = true
    while user_wants_to_play?(replay_option)
      player_option = command_line_ui.get_player_option
      play_single_round(setup_game(player_option))
      replay_option = command_line_ui.replay?
    end
  end

  def play_single_round(game)
    final_board = game.play
    command_line_ui.print_game_status(final_board)
  end

  private

  attr_reader :game, :command_line_ui, :board_factory, :player_factory

  def user_wants_to_play?(replay_option)
    replay_option == true
  end

  def setup_game(player_option)
    Game.new(board_factory.create_board, player_factory.create_players(player_option, command_line_ui))
  end
end
