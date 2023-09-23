-- downwardPipes.lua

function createDownwardPipes(sprite, init_x, init_y)
  pipeDown = sprite
  return {
    x = init_x,
    y = init_y,
    width = pipeDown:getWidth(),
    height = pipeDown:getHeight(),
    speed = 70,
    update = function(self, dt)
      self.x = self.x - self.speed * dt
    end,
    draw = function(self)
      love.graphics.draw(pipeDown, self.x, self.y)
      love.graphics.setColor(1, 1, 1)
    end
  }
end