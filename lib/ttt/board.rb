module TicTacToe
  class Board
    attr_accessor :spaces, :solutions

    def initialize
      @spaces = %w[1 2 3 4 5 6 7 8 9]
      winning_solutions
    end

    def translate_board_state_with_blanks
      @spaces.reduce("") do |blank_spaces, spaces|
        if !spaces.to_i.zero?
          blank_spaces << '_'
        else
          blank_spaces << spaces
        end
      end
    end

    def place_move(piece, *indices)
      indices.each do |space|
        @spaces[(space.to_i)-1] = piece
      end
    end

    def undo_move(space)
      @spaces[(space.to_i)-1] = space.to_s
    end

    def is_space_taken?(space)
      @spaces[(space.to_i) - 1].to_i == 0
    end

    def tied_game?
      all_spaces_taken? && !has_winner?
    end

    def all_spaces_taken?
      (@spaces.count { |x| x == 'X' } + @spaces.count { |x| x == 'O' }) == 9
    end

    def has_winner?
      @solutions.find { |sol| is_solution_found?(sol)}
    end

    def empty_spaces
      @spaces.select { |x| x.to_i != 0}
    end

    def winner
      winner = ""
      @solutions.find { |sol| winner = @spaces[sol[0]-1] if is_solution_found?(sol)}
      winner
    end

    def is_board_empty?
      !@spaces.include?("X") && !@spaces.include?("O")
    end

    def self.represent_board_state(board_state)
      new_board_for_translation = self.new
      translated_board_spaces = []
      new_spaces_for_translation = board_state.split('')
      new_spaces_for_translation.each_index do |index|
        if new_spaces_for_translation[index] == '_' || new_spaces_for_translation[index].to_i != 0
          translated_board_spaces << (index + 1).to_s
        else
          translated_board_spaces << new_spaces_for_translation[index]
        end
      end
      new_board_equals_translated_board_spaces(new_board_for_translation, translated_board_spaces)
    end

    def self.new_board_equals_translated_board_spaces(new_board, translated)
      new_board.spaces = translated
      new_board
    end

    def translate_board_with_indices
      @spaces.join
    end

    def get(space)
      @spaces[(space.to_i)-1]
    end

    def is_solution_found?(spaces)
      spaces.map { |s| @spaces[s-1]}.uniq.length == 1 
    end

    private
    def winning_solutions
      @solutions = [[1,2,3], [4,5,6], [7,8,9],
                    [1,4,7], [2,5,8], [3,6,9],
                    [1,5,9], [3,5,7]]
    end

  end
end
