class Wall
    Friction = 0.6
    Elasticity = 0.2
    attr_reader :body, :width, :height
    def initialize(window, x, y, width, height)
        space = window.space
        @x = x
        @y = y
        @width = width
        @height = height
        @body = CP::Body.new_static()
        @body.p = CP::Vec2.new(x,y)
        width_bound = (width / 2)
        height_bound = (height / 2)
        @bounds = [CP::Vec2.new(-width_bound, -height_bound),
                   CP::Vec2.new(-width_bound, height_bound),
                   CP::Vec2.new(width_bound, height_bound),
                   CP::Vec2.new(width_bound, -height_bound)]
        @shape = CP::Shape::Poly.new(@body, @bounds, CP::Vec2.new(0, 0))
        @shape.u = Friction
        @shape.e = Elasticity
        space.add_shape(@shape)
    end    
end