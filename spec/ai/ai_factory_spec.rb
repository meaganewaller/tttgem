require 'spec_helper'

describe TicTacToe::AIRules::Factory do
  it "makes an unbeatable AI move" do
    move = { :difficulty => :unbeatable_ai,
             :board => TicTacToe::Board.new,
             :mark => "O" }
    TicTacToe::AIRules::UnbeatableAI.should_receive(:make_move).and_return("5")
    ai = described_class.get(move)
    ai.should == "5"
  end  
end
