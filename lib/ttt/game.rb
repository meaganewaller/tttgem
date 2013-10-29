module TicTacToe
  class Game
    attr_reader :ui, :board, :player_one, :player_two
    attr_accessor :over

    def initialize(ui, config={}, over = false)
      @ui = ui
      game_config(config) if !config.empty?
      @over = over
    end

    def self.play_game(ui, config, move="")
      game = self.new(ui, config)
      game.set_spaces(config[:game_board])
      player = game.current_player(config[:game_board])

      if game.board.is_board_empty? && player.class != AI
        game.ui.display_message
        game.ui.print_board(game.board)
        game.place_move(player.mark, move)
      elsif game.is_over?
        game.ui.display_result(game.result)
        game.over = true
      else
        game.ui.ask_move(player)
        move = game.get_move(player) if player.class == AI
        game.place_move(player.mark, move)
        game.ui.print_board(game.board)

        if game.is_over?
          game.ui.display_result(game.result)
          game.over = true
        end
      end
      game
    end



    def game_config(config)
      @player_one = PlayerFactory.create(:type => config[:player_one].to_sym, :mark => "X")
      @player_two = PlayerFactory.create(:type => config[:player_two].to_sym, :mark => "O")
      @board = TicTacToe::Board.new
    end

    def display_board_state
      @ui.print_board(@board)
    end

    def set_spaces(board)
      @board = Board.represent_board_state(board)
    end

    def is_over?
      tied_game? || has_winner?
    end

    def tied_game?
      @board.tied_game?
    end

    def has_winner?
      @board.has_winner?
    end

    def winner
      @board.winner
    end

    def get_move(player)
      return @ui.ask_move(player) if player.class == Human
      return player.make_move(@board)
    end

    def valid_move?(space)
      !@board.is_space_taken?(space)
    end

    def ask_move(player)
      user_input = @ui.ask_move(player)
      while 0 > user_input || user_input > 9
        invalid_move_message
        user_input = @ui.ask_move(player)
      end
      user_input
    end

    def make_moves(moves={})
      moves[:player_one] = get_move(@player_one)
      if valid_move?(moves[:player_one])
        place_move(@player_one.mark, moves[:player_one])

        if !is_over?
          @ui.print_board(@board) if @player_two.class == Human
          moves[:player_two] = get_move(@player_two)
          place_move(@player_two.mark, moves[:player_two])
          @ui.print_board(@board)
        end
      end
    end

    def invalid_move_message
      @ui.output.puts("Invalid Move, Try Again")
    end

    def place_move(mark, move)
      @board.place_move(mark, move) if !move.empty? && valid_move?(move)
    end

    def start
      display_board_state
      make_moves until is_over?
      end_game
    end

    def end_game
      @ui.print_board(@board)
      @ui.display_result(result)
      again?
    end

    def current_player(board)
      count = 0
      (0..8).each do |space|
        count += 1 if board[space] != "_"
      end

      if count.even? || count.zero?
        return @player_one
      else
        return @player_two
      end
    end

    def again?
      start if @ui.again?
      @over = true
    end

    def result
      return "tie" if tied_game?
      winner
    end

    def unique?(spaces)
      spaces.map { |space| @board.spaces[space-1]}.uniq.length == 1
    end
  end
end
