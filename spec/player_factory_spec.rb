require 'player_factory'
require 'human'

def unbeatable_ai
  TicTacToe::AIRules::UnbeatableAI
end

describe TicTacToe::PlayerFactory  do
  let(:player_factory) { described_class }

  it "creates a human player" do
    input = { type: :human, mark: :X }
    player = player_factory.create(input)
    player.should be_an_instance_of(TicTacToe::Human)
    player.mark.should == :X
  end

  it "creates a computer player" do
    input = {type: :ai, mark: :O, opponent_mark: :X, difficulty: unbeatable_ai }
    player = player_factory.create(input)
    player.should be_an_instance_of(TicTacToe::AI)
    player.mark.should == :O
  end

  it "raises expection if input isn't correct" do
    input = {type: :something, mark: :G}
    expect { player_factory.create(input)}.to raise_error("Invalid Player Type")
  end
end
