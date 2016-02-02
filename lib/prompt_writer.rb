require 'replay_option'
require 'player_options'

class PromptWriter
  def initialize(std_out)
    @std_out = std_out
  end

  def ask_for_next_move
    std_out.puts "Please enter your next move"
  end

  def show_winning_message(symbol)
    std_out.puts "The game has been won by #{symbol}!"
  end

  def show_draw_message
    std_out.puts "The game is a draw!"
  end

  def show_board(board)
    board_to_display = format_board(board)
    std_out.puts board_to_display
  end

  def replay
    std_out.puts "Play again? [#{ReplayOption::Y} to replay]"
  end

  def error_message
    std_out.puts "Incorrect input received!"
  end

  def show_player_options
    std_out.puts "Choose player type: " + PlayerOptions.display_player_options
  end

  private

  attr_reader :std_out

  def divider
    " | "
  end

  def format_board(board)
    cell_number = 0
    divided_rows = board.grid_for_display.map do |row|
      formatted_cells = row.map do |cell|
        cell_number += 1
        display_cell(cell, cell_number)
      end
      formatted_cells.join(divider)
    end
    divided_rows.join(new_line)
  end

  def display_cell(cell, cell_number)
    cell.nil? ? cell_number.to_s : cell.to_s
  end

  def new_line
    "\n"
  end
end
