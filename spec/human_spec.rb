require 'human'

describe TicTacToe::Human do
  let(:human) { human = described_class.new('X')}

  describe "#new" do
    it "creates a player with a mark" do
      human.mark.should == "X"
    end

    it "makes a move on the board" do
      board = TicTacToe::Board.new
      human.make_move(1, board)
    end
  end
end
