class Game
    attr_accessor :player_one, :player_two
    @@win_conditions = [
        ["A1", "A2", "A3"],
        ["B1", "B2", "B3"],
        ["C1", "C2", "C3"],
        ["A1", "B2", "C3"],
        ["A3", "B2", "C1"],
        ["A1", "B1", "C1"],
        ["A2", "B2", "C2"],
        ["A3", "B3", "C3"]
    ]
  def initialize(p1name, p2name)
    @player_one = Player.new(p1name)
    @player_two = Player.new(p2name)
    @active_player = @player_one
    @boxes = {}
    ["A", "B", "C"].each do |letter|
        (1..3).each do |number|
            @boxes["#{letter}#{number}"] = " "
        end
    end
    self.build_game_board
    puts "#{@active_player.name} has the first turn. Choose a position in the format A1, B2 ..."

    self.play_game
    
  end

  private
  def build_game_board
    puts "   1   2   3  "
    puts "=============="
    puts "A| #{@boxes["A1"]} | #{@boxes["A2"]} | #{@boxes["A3"]} |"
    puts "=============="
    puts "B| #{@boxes["B1"]} | #{@boxes["B2"]} | #{@boxes["B3"]} |"
    puts "=============="
    puts "C| #{@boxes["C1"]} | #{@boxes["C2"]} | #{@boxes["C3"]} |"
    puts "=============="
  end

  def play_game
    loop do
    make_move(@active_player)
    self.build_game_board
    break if check_winner?(@active_player)
    if @active_player == @player_one
        @active_player = @player_two
    else
        @active_player = @player_one
    end
    end
    puts "#{@active_player.name} wins the game."

  end

  def make_move(active_player)
    move = ""
    loop do
    move = gets.chomp
    break if @boxes.key?(move) && @boxes[move] == " " 
    puts "Can only make a move on an empty square."
    end

    @boxes[move] = active_player.mark

  end

  def check_winner?(active_player)
    @@win_conditions.any? do |condition|
        condition.all? do |position|
            @boxes[position] == active_player.mark
        end
    end
  end
end

class Player
    attr_accessor :name, :mark
    @@marks = ["O", "X"]
    def initialize(name)
        @name = name
        @mark = @@marks[0]
        @@marks.shift


    end 
end

game1 = Game.new("Kevin", "Sarah")