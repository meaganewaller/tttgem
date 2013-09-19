require 'ttt'
describe TTT do
  context "#new" do
    it "has a board and a turn" do
      ttt = TTT.new
      ttt.board.should == %w(- - -
                             - - -
                             - - -)
      ttt.turn.should == 'x'
    end

    it "can create a board and a turn from input" do
      ttt = TTT.new(%w(x o x
                       - - -
                       - - -), 'o')
      ttt.board.should == %w(x o x
                             - - -
                             - - -)
      ttt.turn.should == 'o'
    end
  end

  context "#make_move" do
    it "makes a move on the board" do
      ttt = TTT.new
      ttt.make_move(4)
      ttt.board.should == %w(- - -
                             - x -
                             - - -)
    end

    it "switches player after making a move" do
      ttt = TTT.new
      ttt.turn.should == 'x'
      ttt.make_move(3)
      ttt.turn.should == 'o'
    end
  end

  context "#available_spaces" do
    it "has all available spaces" do
      TTT.new.available_spaces.should == [0, 1, 2, 3, 4, 5, 6, 7, 8]
    end

    it "has all available spaces with moves on the board" do
      ttt = TTT.new(%w(x - o
                       o - -
                       x o x))
      ttt.available_spaces.should == [1, 4, 5]
    end
  end

  context "#winning_player?" do
    it "returns false when no winner" do
      TTT.new.winning_player?('x').should be_false
      TTT.new.winning_player?('o').should be_false
    end

    it "returns true when x wins in top row" do
      ttt = TTT.new(%w(x x x
                       - - -
                       - - -))
      ttt.winning_player?('x').should be_true
    end

    it "returns true when o wins in top row" do
      ttt = TTT.new(%w(o o o
                       - - -
                       - - -))
      ttt.winning_player?('o').should be_true
    end

    it "returns true when x wins in second row" do
      ttt = TTT.new(%w(- - -
                       x x x
                       - - -))
      ttt.winning_player?('x').should be_true
    end

    it "returns true when x wins in third row" do
      ttt = TTT.new(%w(- - -
                       - - -
                       x x x))
      ttt.winning_player?('x').should be_true
    end

    it "returns true when x wins in first col" do
      TTT.new(%w(x - -
                 x - -
                 x - -)).winning_player?('x').should be_true
    end

    it "returns true when x wins in second col" do
      TTT.new(%w(- x -
                 - x -
                 - x -)).winning_player?('x').should be_true 
    end

    it "returns true when x wins in third col" do
      TTT.new(%w(- - x
                 - - x
                 - - x)).winning_player?('x').should be_true
    end

    it "returns true when x wins in main diag" do
      TTT.new(%w(x - -
                 - x -
                 - - x)).winning_player?('x').should be_true
    end

    it "returns true when x wins in min diag" do
      TTT.new(%w(- - x
                 - x -
                 x - -)).winning_player?('x').should be_true
    end
  end

  context "#count_empty_spaces" do
    it "has number of empty spaces" do
      TTT.new.count_empty_spaces.should == 9
    end
  end

  context "#new_move" do
    it "creates a deep copy of the board and the turn" do
      ttt = TTT.new
      new_ttt = TTT.new(%w(- x -
                           - - -
                           - - -), 'o')
      ttt.new_move(1).board.should == new_ttt.board
      ttt.new_move(2).turn.should == new_ttt.turn
      ttt.board.should_not == new_ttt.board
      ttt.turn.should_not == new_ttt.turn
    end
  end

  context "#possible_moves" do
    it "returns all the possible moves for a given position" do
      ttt = TTT.new(%w(x x -
                       o o x
                       - o x), 'x')
      boards = ttt.possible_moves.map(&:board)
      boards.should include(%w(x x x
                               o o x
                               - o x))
      boards.should include(%w(x x -
                               o o x
                               x o x))
    end
  end

  context "#minimax" do
    it "determines a win for x" do
      TTT.new(%w(x x x
                 - - -
                 - - -)).minimax.should == 100
    end

    it "determines a win for o" do
      TTT.new(%w(o o o
                 - - -
                 - - -)).minimax.should == -100
    end

    it "determines a tie" do
      TTT.new(%w(x o x
                 o x o
                 o x o)).minimax.should == 0
    end

     it "determines a win for x in one move" do
      ttt = TTT.new(%w(x x -
                       - - -
                       - - -), 'x')
      ttt.minimax.should == 100 + (ttt.count_empty_spaces)
    end

    it "determines a win for o in one move" do
      ttt = TTT.new(%w(o o -
                       - - -
                       - - -), 'o')
      ttt.minimax.should == -100 - (ttt.count_empty_spaces)
    end 
  end

  context "#possible_values" do
    it "returns the value of the space for x" do
      ttt = TTT.new(%w(x x -
                       o x o
                       x o o), 'x')
      ttt.possible_values.should == [100]
    end

    it "returns the value of the space for o" do
      ttt = TTT.new(%w(o o -
                       x o x
                       o x x), 'o')
      ttt.possible_values.should == [-100]
    end
  end
end

