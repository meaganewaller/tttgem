require 'spec_helper'

describe TicTacToe::AI do
  let(:ai) { described_class.new("O") }

  it "makes a move on the board" do
    board = TicTacToe::Board.new
    ai.make_move(board).should == "1"
  end
end
