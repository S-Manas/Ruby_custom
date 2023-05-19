require 'gosu'
require_relative 'Jump'
require_relative 'Startpage'

module ZOrder
    BACKGROUND, BUTTONS, TEXT = 0..2
end
class Difficulty
    def initialize(background)
        super 800,600
        self.caption = "Difficulty Level"
        @font = Gosu::Font.new(20)
        @background = background
    end

    def update
    end

    def button_down(id)
        case id
        when Gosu::MsLeft
            area_clicked(mouse_x,mouse_y)
        end
    end

    def area_clicked(mouse_x,mouse_y)
        if ((mouse_x > 150 && mouse_x < 350) && (mouse_y > 200 && mouse_y < 400))
            close
            window = Jump.new(1, @background)
            @window.show
        end
        if ((mouse_x > 450 && mouse_x < 650) && (mouse_y > 200 && mouse_y < 400))
            close
            window = Jump.new(2, @background)
            @window.show
        end
    end
    def draw_buttons
        Gosu.draw_rect(150,200,200,200,Gosu::Color::BLACK, ZOrder::BUTTONS, mode=:default)
        @font.draw("Easy", 250,300, ZOrder::TEXT,1.0,1.0,Gosu::Color::WHITE)
        Gosu.draw_rect(450,200,200,200,Gosu::Color::BLACK, ZOrder::BUTTONS, mode=:default)
        @font.draw("Difficult", 550,300, ZOrder::TEXT,1.0,1.0,Gosu::Color::WHITE)
    end
    def draw
        draw_buttons
        @background.draw(0,0,ZOrder::BACKGROUND)
    end
end