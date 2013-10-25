require 'spec_helper'
describe TicTacToe::AIEngine do
  let(:board) { TicTacToe::Board.new }
  let(:mark) { 'O' }

  def test_board(board)
    TicTacToe::Board.represent_board_state(board)
  end

  context "making winning moves" do
    it "returns the winning space" do
      board = test_board("XX3XO6OXO")
      described_class.make_move(board, mark).should == "3"
    end

    it "wins instead of tie" do
      board = test_board("XOX45O7OX")
      described_class.make_move(board, mark).should == "5"
    end

    it "wins asap" do
      board = test_board("OX34O6XX9")
      described_class.make_move(board, mark).should == "9"
    end
  end

  context "unbeatable" do
    it "block" do
      board = test_board('OXXXXO7O9')
      described_class.make_move(board, mark).should == "7"
    end
  end
end


describe TicTacToe::MinScore do

  let(:board) { TicTacToe::Board.new }
  let(:mark) { 'O' }

  def test_board(board)
    TicTacToe::Board.represent_board_state(board)
  end

  context "#minimax" do
    let(:depth) { 0 }
    let(:score_min) { -100 }
    let(:score_max) { 100 }
    
    it "returns 100 on a winning board" do
      board = test_board('OOO456789')
      described_class.new(board, mark, depth, score_min, score_max, 1).minimax.should == 100
    end

    it "returns -100 on a losing board" do
      board = test_board('XXX456789')
      described_class.new(board, mark, depth, score_min, score_max, 1).minimax.should == -100
    end

    it "returns 0 on a tied game" do
      board = test_board('XOXOXOOXO')
      described_class.new(board, mark, depth, score_min, score_max, 1).minimax.should == 0
    end

    xit "returns -99 one move away from winning" do
      board = test_board('123OO6789')
      TicTacToe::MaxScore.new(board, mark, depth, score_min, score_max, -1).minimax.should == -99
    end

    it "returns 0 a move before a tie" do
      board = test_board('XOXOXOOX9')
      TicTacToe::MaxScore.new(board, mark, depth, score_min, score_max, -1).minimax.should == 0
    end

    it "returns -100 for win" do
      board = test_board("OOOOOOOO9")
      TicTacToe::MaxScore.new(board, mark, depth, score_min, score_max, -1).minimax.should == -100
    end

    xit "returns -99 when 2 moves away" do
      board = test_board("XX3XO6OXO")
      TicTacToe::MaxScore.new(board, mark, depth, score_min, score_max, -1).minimax.should == -99 
    end
  end
end
