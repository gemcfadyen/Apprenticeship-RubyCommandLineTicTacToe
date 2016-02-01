require 'prompt_writer'
require 'prompt_reader'
require 'player_options'

class CommandLineUI

  def initialize(writer, reader)
    @writer = writer
    @reader = reader
  end

  def get_move_from_player(board)
    validated_input(
      prompt_player_for_next_move_on(board),
      validation_conditions_for_move_on(board),
      reprompt_player_for_next_move_on(board),
      format_move)
  end

  def replay?
    writer.replay
    replay_option = reader.get_input()
    replay_option.upcase == ReplayOption::Y
  end

  def print_game_status(board)
    writer.show_board(board)
    if board.winning_combination?
      return writer.show_winning_message(board.winning_symbol)
    end

    if !board.free_spaces?
      return writer.show_draw_message
    end
  end

  def get_player_option
    validated_input(
      prompt_for_player_options,
      validation_conditions_for_player_options,
      reprompt_for_player_options,
      format_player_option)
  end

  private

  attr_reader :writer, :reader

  def validated_input(prompt_user, valid, reprompt, format)
    prompt_user.call
    input = reader.get_input

    while(!valid.call(input))
      reprompt.call
      input = reader.get_input
    end
    format.call(input)
  end

  def prompt_player_for_next_move_on(board)
    Proc.new do
      writer.show_board(board)
      writer.ask_for_next_move
    end
  end

  def validation_conditions_for_move_on(board)
    Proc.new do |input|
      numeric?(input) ? one_indexed(board.vacant_indices).include?(Integer(input)) : false
    end
  end

  def reprompt_player_for_next_move_on(board)
    Proc.new do
      writer.show_board(board)
      writer.error_message
      writer.ask_for_next_move
    end
  end

  def format_move
    Proc.new do |input|
      zero_indexed(Integer(input))
    end
  end

  def prompt_for_player_options
    Proc.new do
      writer.show_player_options
    end
  end

  def validation_conditions_for_player_options
    Proc.new do |input|
      numeric?(input) ?  PlayerOptions::valid_ids.include?(Integer(input)) : false
    end
  end

  def reprompt_for_player_options
    Proc.new do
      writer.error_message
      writer.show_player_options
    end
  end

  def format_player_option
    Proc.new do |input|
      PlayerOptions::get_player_type_for_id(Integer(input))
    end
  end

  def numeric?(input)
    begin
      Integer(input)
      true
    rescue ArgumentError
      false
    end
  end

  def one_indexed(vacant_indices)
    vacant_indices.collect { |i| i + 1 }
  end

  def zero_indexed(value)
    value - 1
  end
end
