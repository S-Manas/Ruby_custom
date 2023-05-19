require 'gosu'
require 'chipmunk'
require_relative 'enemy'
require_relative 'wall'
require_relative 'collectible'
require_relative 'map_ground'
require_relative 'map_platforms'
require_relative 'player'
require_relative 'camera'

class Jump < Gosu::Window
    attr_reader :space
    Friction = 0.6
    Gravity = 980
    Enemy_Frequency = 0.01
    attr_reader :start_time
    def initialize(difficult, background)
        super(800,600)
        self.caption = 'Jump'
        @game_over = false
        @difficult = difficult
        @space = CP::Space.new
        @bg = background
        @background = Gosu::Image.new(background)
        @space.damping = Friction
        @space.gravity = CP::Vec2.new(0.0,Gravity)
        @enemies = []
        @player = Player.new(self,70,400)
        @camera = Camera.new(self,600,4200)
        @camera.center_on(@player,400,200)
        @floor = Ground.new(self)
        @left = Wall.new(self,-10,800,20,800)
        @platforms = make_platforms
        @gem_score = 0
        @start_time = Gosu.milliseconds
        @font = Gosu::Font.new(20)
        @status = "Lost"
        @f_score = 0
        @cause = "reaching the end"
    end


def button_down(id)
    if id == Gosu::KbSpace or id ==Gosu::KbUp
        @player.jump
    end
    if id == Gosu::KbQ
        close
        window = MainMenu.new()
        window.show
    end
    if id ==Gosu::KbC 
        close
    end
    if id ==Gosu::KbR
        close
        window = Jump.new(@difficult,@bg)
        window.show
    end

end

# def make_gems(x,y)
#     return Collect.new(self,x,y)
# end

def make_platforms
    platforms = []
    gems =[]
    (1..2).each do |row|
        (0..15).each do |column|
            x = column * 300 + 100
            y = row*120 + 65
            x+= rand(100)-50
            if (y<300)
                y -= rand(100)
            end
            num = rand
            if num < 0.60
                platforms.push Platform.new(self,x,y)
            elsif num >0.9
                platforms.push Platform.new(self,x,y) 
                gems.push Collect.new(self,x,y-50)
            end
        end
    end
    @gems_collect = gems
    return platforms
end



def update
    @camera.center_on(@player, 500, 100)
    unless @game_over
        10.times do
            @space.step(1.0/600)
        end
        @gem_score = (@player.remove_gem(@gems_collect,@gem_score)).to_i
        if @player.remove_enemy(@enemies)
            @game_over = true
            @status = "Lost"
            @cause = "enemy killing you"
        end
        windowOpen = Gosu.milliseconds - @start_time 
        @countdown=(((60000/@difficult)-windowOpen )/ 1000).to_i
        if rand < (@difficult*Enemy_Frequency)
            @enemies.push Enemy.new(self,200 + rand(3800), -20)
        end
        @player.check_footing(@platforms,@floor.holes_arr)
        if button_down?(Gosu::KbRight)
            @player.move_right
        elsif button_down?(Gosu::KbLeft)
            @player.move_left
        else
            @player.stand
        end
        if(@player.y > 500)
            @game_over = true
            @status = "Lost"
            @cause ="falling in hole"
        end
        if(@player.x > 4000)
            @game_over = true
            @status = "Won"
        end
        if @countdown < 0
            @game_over = true
            @status = "Lost"
            @cause = "time up"
        end
    end
end

def draw
    @camera.view do
        (0..3).each do |row|
            (0..4).each do |column|
              @background.draw(1000 * column,row, 0)
            end
        end
        @enemies.each do |enemy|
            enemy.draw
        end
        @platforms.each do |platform|
            platform.draw
        end
        @gems_collect.each do |gem|
            gem.draw
        end
        @player.draw
        @floor.draw_terrain
    end
    if @game_over == false
        @score = @countdown
        #((Gosu.milliseconds-@start_time)/1000) - (2*@difficult*50)
        @font.draw("time left #{@score}", 10,50,3,1,1,0xff00ff00)

        @font.draw("Collected #{@gem_score}", 10,20,3,1,1,0xff00ff00)
      else
        @f_score = @score + @gem_score
        if @difficult == 1
            diff ="Easy"
        end
        if @difficult == 2
            diff = "Difficult"
        end 

        @font.draw("You have " + @status + " the Game by #{@cause}", 200,100,3,1.5,1.5,0xff00ff00)
        @font.draw("Final Score: #{@f_score} on difficulty #{diff} ", 200,140,3,1.5,1.5,0xff00ff00)
        @font.draw("Press Q to go to the main menu", 200,180,3,1.5,1.5,0xff00ff00)
        @font.draw("Press C to close the game", 200,220,3,1.5,1.5,0xff00ff00)
        @font.draw("Press R to Retry", 200,260,3,1.5,1.5,0xff00ff00)



        # @font.draw("", 250,150,3,1.5,1.5,0xff00ff00)

    
      end   
end
end

# window = Jump.new(1,"../images/forest_background.png")
# window.show