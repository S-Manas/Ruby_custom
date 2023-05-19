require 'gosu'
require_relative 'Jump'
require_relative'collectible'

TOP_COLOR = Gosu::Color.new(0x191A19)
BOTTOM_COLOR = Gosu::Color.new(0x70191A19)
TEXT_COLOR = Gosu::Color.new(0xffFF8243)

module ZOrder
    BACKGROUND, MENU, UI = *0..2
end

class MainMenu < Gosu::Window

    def initialize
        super 800, 600
		self.caption = "Main Menu"
        # @background = Gosu::Image.new("../images/space_bg.png")
        @forest = Gosu::Image.new("../images/forest.png")
        @redbg = Gosu::Image.new("../images/red.png")
        @city = Gosu::Image.new("../images/city.png")
        @space = Gosu::Image.new("../images/space.png")
		@font = Gosu::Font.new(30)
        @difficult = 1
        @ruby = Gosu::Image.new("../images/gem.png")
        @wheel = Gosu::Image.new("../images/wheel.png")
        @map = "../images/space_bg.png"
    end

    def update
    end

    def button_down(id)
		case id
		when Gosu::MsLeft
			area_clicked(mouse_x, mouse_y)
	    end
	end

    def draw_menu
        draw_quad(50,50, BOTTOM_COLOR, 50, 200, TOP_COLOR, 400, 50, BOTTOM_COLOR, 400, 200, BOTTOM_COLOR, 10)
    end

    def know
        @ruby.draw(50, 200,10)
        @font.draw("Avoid", 250 , 220, 3,0.5, 0.5, TEXT_COLOR)
        @font.draw("Collect", 110 , 220, 3, 0.5, 0.5 , TEXT_COLOR)
        @wheel.draw(200,200,10)
    end

    def draw_menu_options
        @font.draw("Play Game", 100 , 125, 3, 1.0, 1.0, TEXT_COLOR)
        draw_quad(80,120,0xff_7F7C82,300,120,0xff_7F7C82,300,155,0xff_7F7C82,80,155,0xff_7F7C82,ZOrder::UI)
        @font.draw("Exit", 100 , 165, 3, 1.0, 1.0, TEXT_COLOR)
        draw_quad(80,270,0xff_7F7C82,300,270,0xff_7F7C82,300,305,0xff_7F7C82,80,305,0xff_7F7C82,ZOrder::UI)

    end

    def draw_diff
        @font.draw("Difficulty", 140 , 470, 3, 1.0, 1.0, Gosu::Color::BLUE)            
        # draw_quad(50,425, BOTTOM_COLOR, 50, 425, TOP_COLOR, 400, 425, BOTTOM_COLOR, 400, 425, BOTTOM_COLOR, 10)       
        Gosu.draw_rect(92,510,75,50,Gosu::Color::WHITE,ZOrder::UI)
        @font.draw("Easy", 100,520, 3, 1.0,1.0,Gosu::Color::BLACK)
        Gosu.draw_rect(220,510,100,50,Gosu::Color::WHITE,ZOrder::UI)
        @font.draw("Difficult", 225,520, 3, 1.0,1.0,Gosu::Color::BLACK)
    end

    def instruction
        draw_quad(50,250, BOTTOM_COLOR, 50, 440, TOP_COLOR, 400, 440, BOTTOM_COLOR, 400, 250, BOTTOM_COLOR, 10)
        @font.draw("Background Selection", 100 , 270, 3, 1.0, 1.0, Gosu::Color::BLUE)            
        @font.draw("Select a Background from ", 75 , 310, 3, 1.0, 1.0, TEXT_COLOR)
        @font.draw("the list of images on the ", 75 , 340, 3, 1.0, 1.0, TEXT_COLOR)
        @font.draw("right, then select difficulty ", 75 , 370, 3, 1.0, 1.0, TEXT_COLOR)
        @font.draw("and then the Play Game", 75 , 400, 3, 1.0, 1.0, TEXT_COLOR)

    end

    def draw_map
        @forest.draw(500,50,ZOrder::UI)
        @redbg.draw(500,175,ZOrder::UI)
        @city.draw(500,300,ZOrder::UI)
        @space.draw(500,425,ZOrder::UI)
    end

    def area_clicked(mouse_x, mouse_y)
        if ((mouse_x >92 && mouse_x < 165)&& (mouse_y > 510 && mouse_y < 560 ))
            @difficult = 1
            # Gosu.draw_rect(91,469,77,52,Gosu::Color::BLACK,ZOrder::UI)
		end
        if ((mouse_x >220 && mouse_x < 320)&& (mouse_y > 510 && mouse_y < 560 ))
            @difficult = 2
            # Gosu.draw_rect(219,319,77,52,Gosu::Color::BLACK,ZOrder::UI)
		end
        # Menu Options
        if ((mouse_x >80 && mouse_x < 300)&& (mouse_y > 120 && mouse_y < 155 ))
            close
            window = Jump.new(@difficult,@map)
            window.show
		end
		
		if ((mouse_x >80 && mouse_x < 300)&& (mouse_y > 165 && mouse_y < 200 ))
            puts "Exit"
            close
        end

        # Selecting Map
        if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 50 && mouse_y < 150 ))
            @map = "../images/forest_background.png"
            # Gosu.draw_rect(499,49,202,102,Gosu::Color::BLACK,15)
        end
        if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 175 && mouse_y < 275 ))
            @map = "../images/red_background.png"
            # Gosu.draw_rect(499,174,202,102,Gosu::Color::BLACK,ZOrder::UI)
        end
        if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 300 && mouse_y < 400 ))
            @map = "../images/city_bg.png"
            # Gosu.draw_rect(499,424,202,102,::Color::BLACK,ZOrder::UI)
        end
        if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 425 && mouse_y < 525 ))
            @map = "../images/space_bg.png"
        end
    end

    def draw
        draw_menu
        draw_menu_options
        draw_map
        instruction
        draw_diff
        know
        # @background.draw(0,0,ZOrder::BACKGROUND)
        draw_quad(0, 0, Gosu::Color::GRAY, 800, 0, Gosu::Color::GRAY, 0, 600, Gosu::Color::GRAY, 800, 600, Gosu::Color::GRAY, ZOrder::BACKGROUND)
        @font.draw("Main Menu", 150 , 75, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLUE)
        if(@difficult==1)
            Gosu.draw_rect(87,505,85,60,Gosu::Color::BLACK,ZOrder::MENU)
        elsif (@difficult == 2)
            Gosu.draw_rect(215,505,110,60,Gosu::Color::BLACK,ZOrder::MENU)
        end
        if @map == "../images/forest_background.png"
            Gosu.draw_rect(495,45,210,110,Gosu::Color::BLACK,ZOrder::MENU)
        end
        if @map == "../images/red_background.png"
            Gosu.draw_rect(495,170,210,110,Gosu::Color::BLACK,ZOrder::MENU)
        end
        if @map == "../images/city_bg.png"
            Gosu.draw_rect(495,295,210,110,Gosu::Color::BLACK,ZOrder::MENU)
        end
        if @map == "../images/space_bg.png"
            Gosu.draw_rect(495,420,210,110,Gosu::Color::BLACK,ZOrder::MENU)
        end
        
    end
end

window = MainMenu.new
window.show