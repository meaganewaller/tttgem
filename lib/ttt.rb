class TTT
  PLAYER_ONE = 'x'
  PLAYER_TWO = 'o'
  
  attr_accessor :board, :current_player

  def initialize(board = Array.new(9) {"-"}, current_player = PLAYER_ONE)
    @board = board
    @current_player = current_player 
  end

  def make_move(space)
    @board[space] = @current_player
    @current_player = @current_player == PLAYER_ONE ? PLAYER_TWO : PLAYER_ONE
  end
  
  def available_spaces
    @board.map.with_index { |space, index| index if space == '-' }.compact
  end

  def new_board_with_move(space)
    board_with_current_player = deep_copy
    board_with_current_player.make_move(space)
    board_with_current_player
  end

  def deep_copy
    copy = dup
    copy.board = board.dup
    copy.current_player = current_player.dup
    copy
  end

  def possible_boards
    available_spaces.map { |space| new_board_with_move(space) }
  end

  def possible_values
    possible_boards.map { |board| board.minimax }
  end

  def best_move
    return available_spaces.max_by { |space| new_board_with_move(space).minimax } if @current_player == PLAYER_ONE
    return available_spaces.min_by { |space| new_board_with_move(space).minimax } if @current_player == PLAYER_TWO 
  end

  def minimax
    return 100 if x_won 
    return -100 if o_won 
    return 0 if tie
    return possible_values.max + available_spaces.count if @current_player == PLAYER_ONE 
    return possible_values.min - available_spaces.count if @current_player == PLAYER_TWO 
  end

  def x_won
    winning_player?(PLAYER_ONE)
  end

  def o_won
    winning_player?(PLAYER_TWO)
  end

  def tie
    !winning_player?(PLAYER_ONE) &&
    !winning_player?(PLAYER_TWO) &&
    available_spaces.count == 0
  end

  def winning_player?(current_player)
    return true if @board[0..2]                      == [current_player] * 3
    return true if @board[3..5]                      == [current_player] * 3
    return true if @board[6..8]                      == [current_player] * 3
    return true if [@board[0], @board[3], @board[6]] == [current_player] * 3
    return true if [@board[1], @board[4], @board[7]] == [current_player] * 3
    return true if [@board[2], @board[5], @board[8]] == [current_player] * 3
    return true if [@board[0], @board[4], @board[8]] == [current_player] * 3
    return true if [@board[2], @board[4], @board[6]] == [current_player] * 3
  end
end

