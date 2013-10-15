class MockUI
  attr_reader :asked_play_again, :board_printed, :displayed_result, :ask_again, :asked_move, :move, :displayed_message

  def output
    $stdout
  end

  def print_board(board)
    @board_printed = true
  end

  def display_result(result)
    @displayed_result = true
  end

  def display_message
    @displayed_message = true
  end

  def ask_play_again?
    @asked_play_again = true
  end

  def again?
    @ask_again = true
    false
  end

  def ask_move(player)
    @asked_move = true
    @move = "3"
  end
end
