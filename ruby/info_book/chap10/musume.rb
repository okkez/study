# -*- coding: utf-8 -*-

require 'pp'

module BoxedDaughter

  def self.run(*pieces)
    state = Board.new(pieces, nil)
    visited = {}
    stack = []
    stack.push(state)
    visited[state.to_s] = true
    loop do
      if stack.empty?
        puts 'impossible'
        return false
      end
      #state = stack.pop
      state = stack.shift
      # puts state.to_s
      # p state.pieces.find{|v| v.symbol == :M }
      # puts '----'
      # gets
      break if state.goal?
      state.pieces.each do |piece|
        [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dx, dy|
          if state.movable?(piece, dx, dy)
            s = state.move(piece, dx, dy)
            k = s.to_s
            if visited[k].nil?
              stack.push(s)
              visited[k] = true
            end
          end
        end
      end
    end
    File.open('out2.data', 'w+') do |file|
      state.output(file)
    end
    true
  end

  # (0, 0)
  # . . . .
  # . . . .
  # . . . .
  # . . . .
  # . . . . (3, 4)
  #
  #
  class Board

    MAX_HEIGHT = 4
    MAX_WIDTH = 3

    GOAL = [1, 3]

    attr_reader :pieces

    def initialize(pieces, prev)
      @pieces = pieces
      @board = Array.new(MAX_HEIGHT+1){ Array.new(MAX_WIDTH+1){ '.' } }
      @prev = prev
    end

    def [](x, y)
      @board[y][x]
    end

    def []=(x, y, val)
      @board[y][x] = val
    end

    def goal?
      m = @pieces.find{|v| v.symbol == :M }
      [m.x, m.y] == GOAL
    end

    def parse(str)
      # TODO
    end

    def movable?(piece, dx, dy)
      return false if piece.x + dx < 0
      return false if piece.x + piece.width - 1 + dx > MAX_WIDTH
      return false if piece.y + dy < 0
      return false if piece.y + piece.height - 1 + dy > MAX_HEIGHT
      pieces = @pieces.map(&:dup)
      pieces = pieces.reject{|v| v == piece }
      p = piece.dup
      p.x += dx
      p.y += dy
      pieces.all?{|v| !p.colision?(v) }
    end

    def move(piece, dx, dy)
      i = @pieces.index(piece)
      pieces = @pieces.map(&:dup)
      p = piece.dup
      p.x += dx
      p.y += dy
      pieces[i] = p
      s = self.class.new(pieces, self)
      s
    end

    def to_s
      @pieces.each do |piece|
        piece.area.each do |x, y|
          self[x, y] = piece.symbol
        end
      end
      @board.map{|row| row.map(&:to_s).join('') }.join("\n")
    end

    def output(file)
      @prev.output(file) unless @prev.nil?
      file.puts to_s
      file.puts '------'
    end
  end

  class Piece
    attr_accessor :name, :symbol
    attr_accessor :width, :height
    attr_accessor :x, :y

    def initialize(name, symbol, width, height, x, y)
      @name = name
      @symbol = symbol
      @width = width
      @height = height
      @x = x
      @y = y
    end

    def ==(other)
      self.name == other.name &&
        self.x == other.x &&
        self.y == other.y
    end

    def colision?(other)
      self.area.any?{|v|
        other.area.include?(v)
      }
    end

    def area
      [[x, y], [x + width - 1, y], [x, y + height - 1], [x + width - 1, y + height - 1]]
    end
  end
end

if __FILE__ == $0
  BoxedDaughter.run(BoxedDaughter::Piece.new('娘'  , :M, 2, 2, 1, 0),
                    BoxedDaughter::Piece.new('母親', :v, 1, 2, 0, 0),
                    BoxedDaughter::Piece.new('父親', :v, 1, 2, 3, 0),
                    BoxedDaughter::Piece.new('下男', :v, 1, 2, 0, 2),
                    BoxedDaughter::Piece.new('下女', :v, 1, 2, 3, 2),
                    BoxedDaughter::Piece.new('番頭', :w, 2, 1, 1, 2),
                    BoxedDaughter::Piece.new('小僧', :s, 1, 1, 0, 4),
                    BoxedDaughter::Piece.new('小僧', :s, 1, 1, 1, 3),
                    BoxedDaughter::Piece.new('小僧', :s, 1, 1, 2, 3),
                    BoxedDaughter::Piece.new('小僧', :s, 1, 1, 3, 4))
end
