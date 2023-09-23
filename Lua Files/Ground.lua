-- Ground.lua

function createGround(init_x, init_y, init_width, init_height, init_color)
  return {
    color = init_color,
    x = init_x,
    y = init_y,
    width = init_width,
    height = init_height,
    draw = function(self)
      love.graphics.setColor(self.color)
      love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
      love.graphics.setColor(1, 1, 1)
    end
  }
end