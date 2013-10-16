require 'spec_helper'
describe TicTacToe::Game do
  let(:ui) { MockUI.new }
  let(:settings) {{:player_one => :human, :player_two => :ai }}
  let(:game) {described_class.new(ui, settings)}

  describe "#game_config" do
    before(:each) do
      game.game_config({:player_one => :human, :player_two => :ai})
    end

    it "creates the first player" do
      game.player_one.class.should == TicTacToe::Human
    end

    it "creates the second player" do
      game.player_two.class.should == TicTacToe::AI
    end

    it "creates a board" do
      game.board.spaces.count.should == 9
    end
  end

  describe "#is_over?" do
    it "is true when over" do
      game.set_spaces("OXOXOXXOX")
      game.is_over?.should be_true
    end
  end

  describe "#again?" do
    it "asks user to play again" do
      game.set_spaces("OXOXOXXOX")
      game.start
      ui.ask_play_again?.should be_true
      game.over.should be_true
    end
  end

  describe "#result" do
    it "returns X as winner" do
      game.set_spaces('X234X678X')
      game.result.should == "X"
    end

    it "returns O as winner" do
      game.set_spaces('O234O678O')
      game.result.should == "O"
    end

    it "returns a tie" do
      game.set_spaces('OXOXOXXOX')
      game.result.should == "tie"
    end
  end

  describe "#start" do
    before(:each) do
      game.stub(:has_winner).and_return(true)
    end

    it "prints board after game over" do
      game.set_spaces("OOO456789")
      game.start
      game.ui.board_printed.should be_true
    end
  end


  describe "#new" do
    it "gets the ui" do
      game.ui.class.should == MockUI
    end

    it "has players" do
      game.player_one.should_not be_nil
      game.player_two.should_not be_nil
    end
    
    it "can set a board" do
      game.set_spaces("X234567O9")
      game.board.spaces.should == ["X", "2", "3", "4", "5", "6", "7", "O", "9"]
    end
  end

  context "#has_winner" do
    it "has a winner" do
      game.set_spaces('123OOO789')
      game.has_winner?.should be_true
    end

    it "doesnt have a winner" do
      game.set_spaces('1234O6789')
      game.has_winner?.should be_false
    end
  end

  context "#matches?" do
    it "doesnt match without marks" do
      game.unique?([1,2, 5]).should be_false
    end  

    it "matches with moves" do
      game.set_spaces('XXX456789')
      game.unique?([1,2,3]).should be_true
    end
  end

  context "#tied_game?" do
    it "is true for a tie" do
      game.set_spaces('XOXOXOOXO')
      game.tied_game?.should be_true
    end
  end

  context "#winner" do
    it "returns X" do
      game.set_spaces("XXX456789")
      game.winner.should == "X"
    end

    it "returns O" do
      game.set_spaces("OOO456789")
      game.winner.should == "O"
    end

    it "doesnt have a winner" do
      game.set_spaces("XXO456789")
      game.winner.should == ""
    end
  end

  describe "#display_result" do
    it "displays for a tie" do
      game.should_receive(:is_over?).and_return(true)
      game.start
      game.ui.displayed_result.should be_true
    end
  end

  describe "valid_move?" do
    it "is true for a valid move" do
      game.valid_move?("3").should be_true
    end

    it "returns false for invalid move" do
      game.set_spaces("1234X6789")
      game.valid_move?("5").should be_false
    end
  end

  describe "#current_player" do
    it "returns for X" do
      player = game.current_player('_________')
      player.should == game.player_one
    end

    it "returns for O" do
      player = game.current_player("X_________")
      player.should == game.player_two
    end

    it "returns X after moves are made" do
      player = game.current_player("X__O______")
      player.should == game.player_one
    end
  end

  describe "#play_game" do
    let(:config) {{:player_one => :ai, :player_two => :human, :game_board => '_________'}}

    it "checks for game over" do
      config[:player_one] = :human
      config[:player_two] = :ai
      config[:game_board] = "O2O45X789"
      game = described_class.play_game(ui, config)
      game.board.to_s.should == "OOO45X789"
      game.over.should be_true
    end

    it "asks player for their move" do
      config[:game_board] = "12345X789"
      described_class.play_game(ui, config)
      ui.asked_move.should be_true
    end

    it "doesnt make a move for the human" do
      config[:player_one] = :human
      new_game = described_class.play_game(ui, config, "4")
      new_game.board.to_s.should == "123X56789"
    end

    it "ends game when game is over" do
      config[:game_board] = "XXX456789"
      new_game = described_class.play_game(ui, config)
      new_game.over.should be_true
    end

    it "makes a move if computer is first and board is empty" do
      new_game = described_class.play_game(ui, config)
      new_game.board.to_s.should == "X23456789"
      player = game.current_player(new_game.board.to_s)
      player.should == game.player_two
    end

    it "doesnt make a move when game is over" do
      config[:game_board] = "OOO456789"
      new_game = described_class.play_game(ui, config)
      new_game.board.to_s.should == "OOO456789"
    end

    it "lets human make first move" do
      config[:player_one] = :human
      new_game = described_class.play_game(ui, config, "5")
      new_game.board.to_s.should == "1234X6789"
    end

    it "makes a move when computer is second turn" do
      config[:player_one] = :human
      config[:player_two] = :ai
      config[:game_board] = "12X456789"
      new_game = described_class.play_game(ui, config)
      new_game.board.to_s.should == "12X4O6789"
    end
  end

  describe "#place_move" do
    it "places move on the board" do
      game.place_move("X", "4")
      game.board.spaces.should == %w(1 2 3 X 5 6 7 8 9)
    end
  end

  describe "#make_moves" do
    it "receives output" do
      game.ui.should_receive(:ask_move).and_return(-1, 4)
      game.ui.output.should_receive(:puts)
      game.ask_move(game.player_one)
    end

    it "prints the board when the game is over and its human v human" do
      game.ui.should_receive(:ask_move).once
      game.player_two.stub(:class).and_return(TicTacToe::Human)
      game.ui.stub(:ask_move).and_return("5")
      game.set_spaces("123X5X789")
      game.make_moves
    end

    it "prints the board" do
      game.ui.should_receive(:print_board)
      game.make_moves
    end
  end

  describe "#get_move" do
    it "makes the human move" do
      game.player_one.stub(:class).and_return(TicTacToe::Human)
      game.ui.should_receive(:ask_move).and_return("1")
      game.get_move(game.player_one).should == "1"
    end

    it "makes a computer move" do
      game.player_one.stub(:class).and_return(TicTacToe::AI)
      game.player_one.should_receive(:make_move).with(game.board).and_return("2")
      game.get_move(game.player_one).should == "2"
    end
  end
end
