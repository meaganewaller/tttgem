require 'ttt'

class Game
  attr_accessor :ttt

  def initialize
    @ttt = TTT.new
  end

  def play(ui)
    ui.display_board(@ttt)
    move = ui.ask_for_move(@ttt)
    @ttt.make_move(move)
    while !over?
      ui.display_board(@ttt)
      @ttt.make_move(computer_move)
      ui.display_board(@ttt)
      move = ui.ask_for_move(@ttt) if !over?
      @ttt.make_move(move)
      ui.display_board(@ttt)
    end
    Game.new.play(ui) if ui.play_again?
    move
  end

  def move(space)
    @ttt.make_move(space)
  end

  def computer_move
    @ttt.best_move
  end

  def over? 
    return true if @ttt.x_won || @ttt.o_won || @ttt.tie
  end
end
