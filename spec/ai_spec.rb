require 'spec_helper'

describe TicTacToe::AI do
  let(:ai) { described_class.new("O") }

  it "sets to unbeatable AI" do
    ai.difficulty = :unbeatable_ai
    ai.difficulty.should == :unbeatable_ai 
  end

  it "makes a move on the board" do
    board = TicTacToe::Board.new
    ai.difficulty = :unbeatable_ai
    ai.make_move(board).should == "1"
  end
  
end
