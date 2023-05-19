class Enemy
    Speed_Limit = 500
    Friction = 0.7
    Elasticity = 0.9
    attr_reader :body, :width, :height
    def initialize(window, x, y)
        @body = CP::Body.new(400,4000)
        @body.p = CP::Vec2.new(x,y)
        @body.v_limit = Speed_Limit
        bounds =[CP::Vec2.new(-14,-16),
                CP::Vec2.new(-14,17),
                CP::Vec2.new(15,17),
                CP::Vec2.new(15,-16)]
        @shape = CP::Shape::Poly.new(@body, bounds, CP::Vec2.new(0,0))
        @shape.u = Friction
        @shape.e = Elasticity
        @width = 29
        @height = 33
        window.space.add_body(@body)
        window.space.add_shape(@shape)
        # @ene_walk1, @ene_walk2, @ene_die = Gosu::Image.load_tiles('../images/wheel.jpeg',29,33)
        @current_e_pose = Gosu::Image.new('../images/wheel.png')

        @body.apply_impulse(CP::Vec2.new(rand(100000) - 50000, 100000),CP::Vec2.new(0,0))
    end

    def draw
        @current_e_pose.draw_rot(@body.p.x, @body.p.y, 1, @body.angle * (180/Math::PI))
    end
end

