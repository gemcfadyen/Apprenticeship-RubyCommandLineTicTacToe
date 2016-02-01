require 'prompt_writer'
require 'board'
require 'player_symbols'

RSpec.describe PromptWriter do
  let(:std_out) { StringIO.new }
  let(:prompt) { PromptWriter.new(std_out) }

  it "prompts for an input" do
    prompt.ask_for_next_move
    expect(std_out.string).to eq "Please enter your next move\n"
  end

  it "displays winning message for X" do
    prompt.show_winning_message(PlayerSymbols::X)
    expect(std_out.string).to eq "The game has been won by X!\n"
  end

  it "displays draw message" do
    prompt.show_draw_message
    expect(std_out.string).to eq "The game is a draw!\n"
  end

  it "displays empty board" do
    board = Board.new
    prompt.show_board(board)
    expect(std_out.string).to eq("1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n")
  end

  it "displays board with occupied cells" do
    board = Board.new([PlayerSymbols::X, nil, nil, PlayerSymbols::O, PlayerSymbols::X, nil, nil, nil, nil])
    prompt.show_board(board)
    expect(std_out.string).to eq("X | 2 | 3\nO | X | 6\n7 | 8 | 9\n")
  end

  it "displays replay option" do
    prompt.replay
    expect(std_out.string).to eq "Play again? [Y to replay]\n"
  end

  it "displays error message" do
    prompt.error_message
    expect(std_out.string).to eq("Incorrect input received!\n")
  end

  it "displays player options" do
    prompt.show_player_options

    expect(std_out.string).to eq("Choose player type: (1) Human vs Human, (2) Human vs Ai, (3) Ai vs Human\n")
  end
end
