require 'chipmunk'

class Collect
    FRICTION = 0.7
    ELASTICITY = 0.8
    attr_reader :body, :width, :height, :shape
    def initialize(window , x, y)
        space = window.space
        @width = 50
        @height = 50
        @body = CP::Body.new_static
        @body.p = CP::Vec2.new(x,y)
        bounds = [
            CP::Vec2.new(-25, -25),
            CP::Vec2.new(-25, 25),
            CP::Vec2.new(25, 25),
            CP::Vec2.new(25, -25),
        ]
        @shape = CP::Shape::Poly.new(@body, bounds, CP::Vec2.new(0, 0))
        @shape.u = FRICTION
        @shape.e = ELASTICITY
        window.space.add_shape(@shape)
        @image = Gosu::Image.new('../images/gem.png')
    end

    def draw
        @image.draw_rot(@body.p.x, @body.p.y, 1, 7)
    end
end