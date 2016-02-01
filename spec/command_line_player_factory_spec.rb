require 'command_line_player_factory'
require 'command_line_ui'

RSpec.describe CommandLinePlayerFactory do
  let(:player_factory) { CommandLinePlayerFactory.new }
  let(:command_line_ui_spy) { instance_double(CommandLineUI) }

  it "creates two human players" do
    players = player_factory.create_players(PlayerOptions::HUMAN_VS_HUMAN, command_line_ui_spy)

    expect(players[0].class).to be HumanPlayer
    expect(players[1].class).to be HumanPlayer
  end

  it "creates a human and a ai computer player" do
    players = player_factory.create_players(PlayerOptions::HUMAN_VS_AI, command_line_ui_spy)

    expect(players[0].class).to be HumanPlayer
    expect(players[1].class).to be AiPlayer
  end

  it "creates a human and a ai computer player" do
    players = player_factory.create_players(PlayerOptions::AI_VS_HUMAN, command_line_ui_spy)

    expect(players[0].class).to be AiPlayer
    expect(players[1].class).to be HumanPlayer
  end
end
