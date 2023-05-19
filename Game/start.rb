# require 'gosu'
# require_relative 'Difficulty'
# require_relative 'd'
# require_relative 'Jump'
# require_relative'collectible'

# TOP_COLOR = Gosu::Color.new(0x191A19)
# BOTTOM_COLOR = Gosu::Color.new(0x70191A19)
# TEXT_COLOR = Gosu::Color.new(0xffFF8243)

# module ZOrder
#     BACKGROUND, MENU, UI = *0..2
# end

# class MainMenu < Gosu::Window

#     def initialize
#         super 800, 600
# 			self.caption = "Main Menu"
#             # @background = Gosu::Image.new("../images/space_bg.png")
#             @forest = Gosu::Image.new("../images/forest.png")
#             @redbg = Gosu::Image.new("../images/red.png")
#             @city = Gosu::Image.new("../images/city.png")
#             @space = Gosu::Image.new("../images/space.png")
# 			@font = Gosu::Font.new(30)
#     end

#     def update
#     end

#     def button_down(id)
# 		case id
# 		when Gosu::MsLeft
# 			area_clicked(mouse_x, mouse_y)
# 	    end
# 	end

#     def draw_menu
#         draw_quad(50,50, BOTTOM_COLOR, 50, 200, TOP_COLOR, 400, 50, BOTTOM_COLOR, 400, 200, BOTTOM_COLOR, 10)
#     end

#     def draw_menu_options
#         @font.draw("Play Game", 100 , 125, 3, 1.0, 1.0, TEXT_COLOR)
#         draw_quad(80,120,0xff_7F7C82,300,120,0xff_7F7C82,300,155,0xff_7F7C82,80,155,0xff_7F7C82,ZOrder::UI)
#         @font.draw("Exit", 100 , 165, 3, 1.0, 1.0, TEXT_COLOR)
#         draw_quad(80,270,0xff_7F7C82,300,270,0xff_7F7C82,300,305,0xff_7F7C82,80,305,0xff_7F7C82,ZOrder::UI)

#         # @font.draw("Exit", 100 , 325, 3, 1.0, 1.0, TEXT_COLOR)
#         # draw_quad(80,320,0xff_7F7C82,300,320,0xff_7F7C82,300,355,0xff_7F7C82,80,355,0xff_7F7C82,ZOrder::UI)
#     end

#     def instruction
#         draw_quad(50,250, BOTTOM_COLOR, 50, 400, TOP_COLOR, 400, 400, BOTTOM_COLOR, 400, 250, BOTTOM_COLOR, 10)
#         @font.draw("Background Selection", 140 , 270, 3, 1.0, 1.0, Gosu::Color::BLUE)            
#         @font.draw("Select a Background from  ", 100 , 310, 3, 1.0, 1.0, TEXT_COLOR)
#         @font.draw("the list of images on the right", 100 , 340, 3, 1.0, 1.0, TEXT_COLOR)
#     end

#     def draw_map
#         @forest.draw(500,50,5)
#         @redbg.draw(500,175,5)
#         @city.draw(500,300,5)
#         @space.draw(500,425,5)
#     end

#     def area_clicked(mouse_x, mouse_y)

#         # Menu Options
#         if ((mouse_x >80 && mouse_x < 300)&& (mouse_y > 120 && mouse_y < 155 ))
#             close
#             window = Jump.new(1,"../images/space_bg.png")
#             window.show
#             puts working
# 		end
		
# 		if ((mouse_x >80 && mouse_x < 300)&& (mouse_y > 165 && mouse_y < 200 ))
#             puts "Exit"
#             close
#         end

#         # Selecting Map
#         if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 50 && mouse_y < 150 ))
#             close
#             window = D.new("../images/forest_background.png")
#             window.show
#             puts working
#         end
#         if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 175 && mouse_y < 275 ))
#             close
#             window = D.new("../images/red_background.png")
#             window.show
#         end
#         if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 300 && mouse_y < 400 ))
#             close
#             window = D.new("../images/city_bg.png")
#             window.show
#         end
#         if ((mouse_x >500 && mouse_x < 700)&& (mouse_y > 425 && mouse_y < 525 ))
#             close
#             window = D.new("../images/space_bg.png")
#             window.show
#         end
#     end

#     def draw
#         draw_menu
#         draw_menu_options
#         draw_map
#         instruction
#         # @background.draw(0,0,ZOrder::BACKGROUND)
#         draw_quad(0, 0, Gosu::Color::GRAY, 800, 0, Gosu::Color::GRAY, 0, 600, Gosu::Color::GRAY, 800, 600, Gosu::Color::GRAY, ZOrder::BACKGROUND)
#         @font.draw("Main Menu", 150 , 75, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLUE)
#     end
# end

# window = MainMenu.new
# window.show