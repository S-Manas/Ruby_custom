class Player
    RUN_IMPULSE = 2000 
    FLY_IMPULSE = 1500 
    JUMP_IMPULSE = 5000000 
    AIR_JUMP_IMPULSE = 120 
    SPEED_LIMIT = 400
    FRICTION = 0.6
    ELASTICITY = 0.2 
    attr_accessor :off_ground
    
    def initialize(window, x, y)
        height = 65
        width = 40
        bound_height = (height/2)
        bound_width = (width/4).to_i
        @window = window
        @space = window.space
        @images = Gosu::Image.load_tiles('../images/chip.png', 40, 65) 
        @body = CP::Body.new(50, 100 / 0.0)
        @body.p = CP::Vec2.new(x, y)
        @body.v_limit = SPEED_LIMIT
        
        bounds = [CP::Vec2.new(-bound_width, -bound_height),
            CP::Vec2.new(-bound_width, bound_height),
            CP::Vec2.new(bound_width, bound_height),
            CP::Vec2.new(bound_width, -bound_height)]
        shape = CP::Shape::Poly.new(@body, bounds, CP::Vec2.new(0, 0))
        shape.u = FRICTION
        shape.e = ELASTICITY
        @space.add_body(@body)
        @space.add_shape(shape)
        @action = :stand
        @image_index = 0
        @off_ground = true
    end

    def x
      @body.p.x
    end
  
    def y
      @body.p.y
    end
    
    def draw
        case @action 
        when :run_right
            @images[@image_index].draw_rot(@body.p.x, @body.p.y, 2, 0)
            @image_index = (@image_index + 0.2) % 7 
        when :stand
            @images[7].draw_rot(@body.p.x, @body.p.y, 2, 0) 
        when :jump_left
            @images[5].draw_rot(@body.p.x, @body.p.y, 2, 0, 0.5, 0.5, -1, 1) 
        when :run_left
            @images[@image_index].draw_rot(@body.p.x, @body.p.y, 2, 0, 0.5, 0.5, -1, 1)
            @image_index = (@image_index + 0.2) % 7 
        when :jump_right
            @images[5].draw_rot(@body.p.x, @body.p.y, 2, 0) 
            @image_index = (@image_index + 0.2) % 7 
        else
            @images[2].draw_rot(@body.p.x, @body.p.y, 2, 0)
        end 
    end

    def touching?(footing)
        x_diff = (@body.p.x - footing.body.p.x).abs
        y_diff = (@body.p.y + 100 - footing.body.p.y).abs
        x_diff < 30 + footing.width/2 and y_diff < 5 + footing.height/2
    end

    def check_footing(things,holes_arr)
      @off_ground = true
      things.each do |thing|
        if touching?(thing)
            @off_ground = false
        end 
      end
      if @body.p.y > 400
        @off_ground = false
      end
      i = 0
      while i < holes_arr.length()
        if (@body.p.x-10 >= holes_arr[i] and @body.p.x <= holes_arr[i]+145 and @body.p.y > 400)
          @off_ground = true
        end
        i+=1
      end
    end

    def move_right
        if @off_ground
          @action = :jump_right
          @body.apply_impulse(CP::Vec2.new(FLY_IMPULSE, 0), CP::Vec2.new(0,0))
        else
          @action = :run_right
          @body.apply_impulse(CP::Vec2.new(RUN_IMPULSE, 0), CP::Vec2.new(0,0))
        end
    end
    
    def move_left
        if @off_ground
          @action = :jump_left
          @body.apply_impulse(CP::Vec2.new(-FLY_IMPULSE, 0), CP::Vec2.new(0,0))
        else
          @action = :run_left
          @body.apply_impulse(CP::Vec2.new(-RUN_IMPULSE, 0), CP::Vec2.new(0,0))
        end
    end

    def jump
        if @off_ground
          @body.apply_impulse(CP::Vec2.new(0, -AIR_JUMP_IMPULSE),CP::Vec2.new(0,0))
        else
          @body.apply_impulse(CP::Vec2.new(0, -JUMP_IMPULSE), CP::Vec2.new(0,0))
          if @action == :left
            @action = :jump_left
          else
            @action = :jump_right
          end
        end
    end

    def stand
        @action = :stand unless off_ground
    end

    def remove_enemy(enemies)
        enemies.reject! do |enemy|
          if(Gosu.distance(@body.p.x, @body.p.y, enemy.body.p.x, enemy.body.p.y) < 50)
            # @space.remove_body(enemy.body)
            # @space.remove_shape(enemy.shape)
            # enemy.body.apply_impulse(CP::Vec2.new(2000, 0),CP::Vec2.new(0,0))
            return true
          end
        end
    end
    def remove_gem(gems,gemScore)
      score = gemScore
      gems.reject! do |gem|
        if(Gosu.distance(@body.p.x, @body.p.y, gem.body.p.x, gem.body.p.y) < 50)
          # @space.remove_body(gem.body)
          @space.remove_shape(gem.shape)
          gem.body.apply_impulse(CP::Vec2.new(2000, 0),CP::Vec2.new(0,0))
          score += 1
        end
      end
      return score
    end

end