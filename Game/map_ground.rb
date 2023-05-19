require_relative 'wall'

class Ground
    attr_accessor :holes_arr
    def initialize(window)
        @hole = Gosu::Image.new("../images/hole1.png",tileable: true)
        @hole2 = Gosu::Image.new("../images/hole2.png",tileable: true)
        @holes_arr = [400,950,1700,2900] 
        i = 0
        last_hole_at = 90 
        while i < @holes_arr.length()
            while last_hole_at < @holes_arr[i]
                if last_hole_at+90 > @holes_arr[i]
                    space_left_to_hole = (@holes_arr[i]-last_hole_at)*2
                    @floor = Wall.new(window, last_hole_at,500,space_left_to_hole,20)
                    last_hole_at = @holes_arr[i] + 180 + 90
                else
                    @floor = Wall.new(window, last_hole_at,500,180,20)
                    last_hole_at += 90
                end
            end
            i += 1
            if i == @holes_arr.length()
                while last_hole_at < 5000
                    @floor = Wall.new(window, last_hole_at,500,180,20)
                    last_hole_at += 90
                end
            end
        end
    end

    def draw_terrain
        i = 0
        while i < @holes_arr.length()
            @hole.draw(@holes_arr[i],390, 0)
            i += 1
        end
    end
end
