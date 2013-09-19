class TTT
  PLAYER_ONE = 'x'
  PLAYER_TWO = 'o'
  
  attr_accessor :board, :turn

  def initialize(board = Array.new(9) {"-"}, turn = PLAYER_ONE)
    @board = board
    @turn = turn
  end

  def make_move(space)
    @board[space] = @turn
    @turn = @turn == PLAYER_ONE ? PLAYER_TWO : PLAYER_ONE
  end
  
  def available_spaces
    @board.map.with_index { |space, index| index if space == '-' }.compact
  end

  def count_empty_spaces
    available_spaces.count
  end

  def new_move(space)
    new_ttt = deep_copy
    new_ttt.make_move(space)
    new_ttt
  end

  def deep_copy
    copy = dup
    copy.board = board.dup
    copy.turn = turn.dup
    copy
  end

  def possible_moves
    available_spaces.map { |space| new_move(space) }
  end

  def possible_values
    possible_moves.map { |move| move.minimax }
  end

  def minimax
    return 100 if winning_player?(PLAYER_ONE)
    return -100 if winning_player?(PLAYER_TWO)
    return 0 if !winning_player?(PLAYER_ONE) &&
                !winning_player?(PLAYER_TWO) &&
                count_empty_spaces == 0
    return possible_values.max + count_empty_spaces if @turn == PLAYER_ONE 
    return possible_values.min - count_empty_spaces if @turn == PLAYER_TWO 
  end

  def best_move
    return available_spaces.max_by { |space| new_move(space).minimax } if @turn == PLAYER_ONE
    return available_spaces.min_by { |space| new_move(space).minimax } if @turn == PLAYER_TWO 
  end

  def winning_player?(turn)
    return true if @board[0..2]                      == [turn] * 3
    return true if @board[3..5]                      == [turn] * 3
    return true if @board[6..8]                      == [turn] * 3
    return true if [@board[0], @board[3], @board[6]] == [turn] * 3
    return true if [@board[1], @board[4], @board[7]] == [turn] * 3
    return true if [@board[2], @board[5], @board[8]] == [turn] * 3
    return true if [@board[0], @board[4], @board[8]] == [turn] * 3
    return true if [@board[2], @board[4], @board[6]] == [turn] * 3
  end
end

