-- Bird.lua

function createBird(sprite)
  birdImage = sprite
  width = birdImage:getWidth()
  height = birdImage:getHeight()
  gravity = 982
  
  return {
    x = 75,
    y = 180,
    velocity = 0,
    update = function(self, dt)
      self.y = self.y + self.velocity * dt + gravity * dt * dt / 2
      self.velocity = self.velocity + gravity * dt
    end,
    jump = function(self)
      while true do
        self.velocity = -300
        coroutine.yield()
      end
    end,
    collision = function(self, p)
      if self.x > p.x + p.width or p.x > self.x + width then
        return false
      end
      if self.y > p.y + p.height or p.y > self.y + height then
        return false
      end
      return true
    end,
    draw = function(self)
      angle = (self.velocity/700)*math.pi/4
      love.graphics.draw(birdImage, self.x, self.y, angle)
      love.graphics.setColor(1, 1, 1)
    end
  }
end