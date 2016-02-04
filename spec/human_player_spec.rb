require 'human_player'
require 'board'
require 'player_symbols'
require 'command_line_ui.rb'

RSpec.describe HumanPlayer do
  let(:command_line_interface_spy) { instance_double(CommandLineUI) }
  let(:symbol) { PlayerSymbols::X }
  let(:human) { HumanPlayer.new(symbol, command_line_interface_spy) }

  it "has a player symbol" do
    expect(human.game_symbol).to be PlayerSymbols::X
  end

  it "has ready state" do
    expect(human.ready?).to be true
  end

  it "chooses a move on the board" do
    expect(command_line_interface_spy).to receive(:get_move_from_player) { 1 }

    move = human.choose_move(Board.new)

    expect(move).to be 1
  end
end
