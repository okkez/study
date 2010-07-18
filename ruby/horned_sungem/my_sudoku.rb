
module Sudoku

  class Board

    ALL_DIGITS = (1..9).to_a

    def initialize(str)
      @board = []
      str.lines.with_index do |line, row|
        line.chomp.split(//).each.with_index do |value, col|
          @board << Cell.new(row, col, value.to_i)
        end
      end
      raise "Initiali puzzle has duplicates" if duplicates?
    end

    def cells
      @board
    end

    def dup
      copy = super
      @board = @board.map{|c| Cell.new(c.row, c.col, c.value) }
      copy
    end

    def inspect
      result = []
      0.upto(8) do |row|
        line = ""
        0.upto(8) do |col|
          c = self[row, col]
          line << (c.value ? c.value.to_s : ".")
        end
        result << line
      end
      result.join("\n")
    end

    def [](row, col)
      @board.find{|cell| cell.row == row && cell.col == col }
    end

    def []=(row, col, value)
      self[row, col].value = value
    end

    def each_unknown
      @board.each do |cell|
        yield cell unless cell.value
      end
    end

    def possible_digits(cell)
      ALL_DIGITS - row_cells(cell.row).map(&:value) -
        col_cells(cell.col).map(&:value) -
        box_cells(box(cell.row, cell.col)).map(&:value)
    end

    def row_cells(row)
      @board.select{|cell| cell.row == row }
    end

    def col_cells(col)
      @board.select{|cell| cell.col == col }
    end

    BOX_ROOT = [
                [0, 0],[0, 3],[0, 6],
                [3, 0],[3, 3],[3, 6],
                [6, 0],[6, 3],[6, 6],
               ]

    def box_cells(box)
      row, col = BOX_ROOT[box]
      [
       self[row,   col], self[row,   col+1], self[row,   col+2],
       self[row+1, col], self[row+1, col+1], self[row+1, col+2],
       self[row+2, col], self[row+2, col+1], self[row+2, col+2],
      ]
    end

    def box(row, col)
      case
      when [0,1,2].include?(row) && [0,1,2].include?(col) then 0
      when [0,1,2].include?(row) && [3,4,5].include?(col) then 1
      when [0,1,2].include?(row) && [6,7,8].include?(col) then 2
      when [3,4,5].include?(row) && [0,1,2].include?(col) then 3
      when [3,4,5].include?(row) && [3,4,5].include?(col) then 4
      when [3,4,5].include?(row) && [6,7,8].include?(col) then 5
      when [6,7,8].include?(row) && [0,1,2].include?(col) then 6
      when [6,7,8].include?(row) && [3,4,5].include?(col) then 7
      when [6,7,8].include?(row) && [6,7,8].include?(col) then 8
      end
    end

    def duplicates?
      0.upto(8){|n| return true if row_cells(n).map(&:value).reject{|v| v.nil? }.uniq! }
      0.upto(8){|n| return true if col_cells(n).map(&:value).reject{|v| v.nil? }.uniq! }
      0.upto(8){|n| return true if box_cells(n).map(&:value).reject{|v| v.nil? }.uniq! }
      false
    end

  end

  class Cell
    attr_accessor :row, :col, :value
    def initialize(row, col, value)
      @row, @col = row, col
      @value = value == 0 ? nil : value
    end
  end

  class << self
    def scan(board)
      unchanged = false
      memo = { }
      until unchanged
        unchanged = true
        board.each_unknown do |cell|
          po = board.possible_digits(cell)
          case po.size
          when 0
            raise Impossible, "(#{cell.row}, #{cell.col})"
          when 1
            cell.value = po.first
            unchanged = false
          else
            memo[cell] = po
          end
        end
      end
      return memo.min_by{|cell, po| po.size }
    end

    def solve(board)
      board = board.dup
      memo_cell, memo_po = scan(board)
      return board unless memo_cell
      memo_po.each do |val|
        board[memo_cell.row, memo_cell.col] = val
        begin
          return solve(board)
        rescue Impossible
          next
        end
      end
      board
    end
  end

  class Impossible < StandardError
  end
end

if __FILE__ == $0
#   lines = []
#   print "(0)> "
#   until (line = gets.chomp).empty?
#     lines << line
#     print "(#{lines.size})> "
#   end
  lines =<<EOD
1..7..3..
.5..9..4.
..3..2..7
8..4..1..
.6..7..5.
..1..8..2
2..3..8..
.1..4..6.
..5..1..4
EOD
  p Sudoku.solve(Sudoku::Board.new(lines))
end

