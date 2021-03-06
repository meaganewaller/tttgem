require 'spec_helper'
require 'pry'

describe TicTacToe::Board do
  let(:board) {  described_class.new }
  
  describe "#new" do
    it "creates blank board with numbers" do
      (1..9).each do |num|
        board.get(num).should == ("#{num}")
      end
    end
  end

  describe "#translate_board_state_with_blanks" do
    it "makes the board representation a string" do
      board.translate_board_state_with_blanks.should == '_________'  
    end

    it "doesn't replace moves with spaces" do
      board.spaces[3] = "X"
      board.translate_board_state_with_blanks.should == '___X_____'
    end
  end

  context "making move" do
    describe "#place_move" do
      it "places a move" do
        board.place_move('X', 0)
        board.get(0).should == "X"
      end

      it "allows multiple inputs" do
        board.place_move('X', 1, 2, 3)
        board.get(1).should == "X"
        board.get(2).should == "X"
        board.get(3).should == "X"
      end
    end

    describe "#undo_move" do
      it "undoes a move" do
        board.place_move('X', 2)
        board.undo_move(2)
        board.get(2).should == "2"
      end
    end
  end

  describe "#is_space_taken?" do
    it "is false when the space isn't taken" do
      board.is_space_taken?(5).should be_false
    end

    it "is true when the space is taken" do
      board.place_move('X', 6)
      board.is_space_taken?(6).should be_true
    end  
  end

  describe "checking for winner" do
    before :each do
      board.place_move('X', 1, 3, 5, 8)
      board.place_move('O', 2, 4, 6, 7, 9)
    end
    describe "#tied_game?" do
      it "is true when the game is tied" do
        board.tied_game?.should be_true
      end
    end
  end

  describe "#full_board?" do
    it "returns true if board is full" do
      board.place_move('X', 1, 3, 5, 8)
      board.place_move('O', 2, 4, 6, 7, 9)
      board.all_spaces_taken?.should be_true
    end

    it "returns false if board not full" do
      board.all_spaces_taken?.should be_false
    end
  end

  describe "#has_winner?" do
    it "returns false with no winner" do
      board.has_winner?.should be_false
    end

    it "returns true with a winner" do
      board.place_move('X', 1, 2, 3)
      board.has_winner?.should be_true
    end
  end

  describe "#empty_spaces" do
    it "returns all the empty spaces in the board" do
      board.empty_spaces.should == %w(1 2 3 4 5 6 7 8 9)
    end

    it "returns all empty spaces with moves" do
      board.place_move('O', 1,2,3)
      board.empty_spaces.should == %w(4 5 6 7 8 9)
    end
  end

  describe "finding winner" do
    it "knows when X is the winner" do
      board.place_move('X', 1, 2, 3)
      board.winner.should == "X"
    end

    it "knows when O is the winner" do
      board.place_move('O', 1, 2, 3)
      board.winner.should == "O"
    end
  end

  describe "#is_board_empty?" do
    it "knows when the board is empty" do
      board.is_board_empty?.should be_true
    end

    it "isn't empty with moves" do
      board.place_move('X', 1)
      board.is_board_empty?.should be_false
    end
  end

  describe "getting and representing the board state" do
    it "represents the board state" do
      test_board_state = 'X23456O89'
      test_board = described_class.represent_board_state(test_board_state)
      test_board_state.split('').each_with_index do |mark, space|
        test_board.get(space+1).should == mark
      end
      test_board.spaces.should be_a(Array)
    end

    it "gets a board and represents it's state" do
      test_board_state = '12345XX8O'
      test_board = described_class.represent_board_state(test_board_state)
      test_board.translate_board_with_indices.should == test_board_state
    end

    it "gets a blank board" do
      test_board_state = '_________'
      test_board = described_class.represent_board_state(test_board_state)
      test_board.translate_board_with_indices.should == "123456789"
    end

    it "gets a board with underscores and some marks" do
      test_board_state = '_X_______'
      test_board = described_class.represent_board_state(test_board_state)
      test_board.translate_board_with_indices.should == "1X3456789"
    end
  end

  describe "#winning_solutions" do
    it "gets all winning solutions for board" do
      board.solutions.should == [[1,2,3], [4,5,6], [7,8,9],
                                 [1,4,7], [2,5,8], [3,6,9],
                                 [1,5,9], [3,5,7]]
    end
  end
end
