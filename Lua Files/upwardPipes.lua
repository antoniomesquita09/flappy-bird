-- upwardPipes.lua

function createUpwardPipes(sprite, init_x, init_y)
  pipeUp = sprite
  return {
    x = init_x,
    y = init_y,
    width = pipeUp:getWidth(),
    height = pipeUp:getHeight(),
    speed = 70,
    update = function(self, dt)
      self.x = self.x - self.speed * dt
    end,
    draw = function(self)
      love.graphics.draw(pipeUp, self.x, self.y)
      love.graphics.setColor(1, 1, 1)
    end
  }
end