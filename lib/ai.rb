class AI
  PLAYER_ONE = 'x'
  PLAYER_TWO = 'o'
  def minimax(ttt)
    return 100 if ttt.winning_player?(PLAYER_ONE)
    return -100 if ttt.winning_player?(PLAYER_TWO)
    return 0 if !ttt.winning_player?(PLAYER_ONE) &&
      !ttt.winning_player?(PLAYER_TWO) &&
      ttt.count_empty_spaces == 0
    return ttt.possible_values.max + ttt.count_empty_spaces if ttt.turn == PLAYER_ONE 
    return ttt.possible_values.min - ttt.count_empty_spaces if ttt.turn == PLAYER_TWO 
  end

  def best_move
    return available_spaces.max_by { |space| ttt.new_move(space).minimax } if ttt.turn == PLAYER_ONE
    return available_spaces.min_by { |space| ttt.new_move(space).minimax } if ttt.turn == PLAYER_TWO 
  end

end
