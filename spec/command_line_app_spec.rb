require 'command_line_app'
require 'command_line_ui'
require 'board'
require 'command_line_ui'
require 'player_symbols'
require 'player_factory'
require 'board_factory'

RSpec.describe CommandLineApp do
  let(:command_line_app) { CommandLineApp.new(command_line_ui_spy, board_factory_spy, player_factory_spy) }
  let(:game_spy) { instance_double(Game).as_null_object }
  let(:command_line_ui_spy) { instance_double(CommandLineUI).as_null_object }
  let(:player_factory_spy) { instance_double(PlayerFactory).as_null_object }
  let(:board_factory_spy) { instance_double(BoardFactory).as_null_object }
  let(:board_spy) { instance_double(Board).as_null_object }

  it "play single round of game and gets status" do
    command_line_app.play_single_round(game_spy)

    expect(game_spy).to have_received(:play)
  end

  it "gets game status" do
    command_line_app.play_single_round(game_spy)

    expect(command_line_ui_spy).to have_received(:print_game_status)
  end

  it "creates board on start" do
    allow(board_factory_spy).to receive(:create_board).and_return(board_spy)
    allow(command_line_ui_spy).to receive(:replay?).and_return(false)
    allow(player_factory_spy).to receive(:create_players).and_return(two_fake_players)

    command_line_app.start

    expect(board_factory_spy).to have_received(:create_board)
  end

  it "asks for player types" do
    allow(board_factory_spy).to receive(:create_board).and_return(board_spy)
    allow(player_factory_spy).to receive(:create_players).and_return(two_fake_players)
    allow(command_line_ui_spy).to receive(:replay?).and_return(false)

    command_line_app.start

    expect(board_factory_spy).to have_received(:create_board)
    expect(command_line_ui_spy).to have_received(:get_player_option)
  end

  it "creates players on start" do
    allow(player_factory_spy).to receive(:create_players).and_return(two_fake_players)
    allow(command_line_ui_spy).to receive(:replay?).and_return(false)
    allow(board_factory_spy).to receive(:create_board).and_return(board_spy)

    command_line_app.start

    expect(player_factory_spy).to have_received(:create_players)
  end

  it "asks user to replay" do
    allow(board_factory_spy).to receive(:create_board).and_return(board_spy)
    allow(player_factory_spy).to receive(:create_players).and_return(two_fake_players)

    command_line_app.start

    expect(command_line_ui_spy).to have_received(:replay?)
  end

  it "play another game when replay selected" do
    allow(board_factory_spy).to receive(:create_board).and_return(board_spy).twice
    allow(player_factory_spy).to receive(:create_players).and_return(two_fake_players)
    allow(command_line_ui_spy).to receive(:replay?).and_return(true, false)

    command_line_app.start

    expect(command_line_ui_spy).to have_received(:replay?).twice
    expect(command_line_ui_spy).to have_received(:print_game_status).twice
  end

  def two_fake_players
    fake_player_x = instance_double(HumanPlayer).as_null_object
    allow(fake_player_x).to receive(:ready?).and_return(true)

    fake_player_o = instance_double(HumanPlayer).as_null_object
    allow(fake_player_o).to receive(:ready?).and_return(true)

    [fake_player_x, fake_player_o]
  end
end
