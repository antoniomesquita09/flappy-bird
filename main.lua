-- main.lua

gamemode = 0
high_score = 0
playing = false

function menu(x,y)
  --menu background 
  local menubackgroundImage = love.graphics.newImage('Assets/gamebackground.jpg')
  
  -- font style
  local font = love.graphics.newFont('Fonts/DIMIS___.TTF', 50)
  
  --pos x,y menu
  local menux,menuy = 100,15
  
  --check what item was clicked
  local click_item = function(mx, my, x, y) return (mx>x) and (mx<x+130) and (my>y) and (my<y+50) end
  
  return {
    draw = function()
      love.graphics.draw(menubackgroundImage, x, y)
      grass:draw()
      dirt:draw()
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(font)
      love.graphics.print("MENU", menux, menuy)
      love.graphics.print("START", menux-5, menuy+90)
      love.graphics.print("CONFIG", menux-10, menuy+180)
      love.graphics.print("SKINS", menux-5, menuy+270)
      love.graphics.setColor(1, 1, 1)
    end,
    keypressed = function(key)
      if key == "space" and gamemode == 0 then
        gamemode = 1
      end
      if key == "c" and gamemode == 0 then
        gamemode = 2
      end
      if key == "s" and gamemode == 0 then
        gamemode = 3
      end
    end, 
    mousepressed = function(mx,my,button)
      if button == 1 and gamemode ==0 and click_item(mx,my,menux-5,menuy+90) then
        gamemode = 1
      elseif button == 1 and gamemode ==0 and click_item(mx,my,menux-10,menuy+180) then
        gamemode = 2
      elseif button == 1 and gamemode ==0 and click_item(mx,my,menux-5,menuy+270) then
        gamemode = 3
      end
    end
  }
end

function config(x,y)
  --config background 
  local configbackgroundImage = love.graphics.newImage('Assets/gamebackground.jpg')
  
  -- font style
  local font = love.graphics.newFont('Fonts/DIMIS___.TTF', 50)
  
  --pos x,y config
  local configx, configy = 90,15
  
  return {
    draw = function()
      love.graphics.draw(configbackgroundImage, x, y)
      grass:draw()
      dirt:draw()
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(font)
      love.graphics.print("CONFIG", configx, configy)
      love.graphics.print("LEVEL:", 15, configy+90)
      love.graphics.print("1", 20, configy+160)
      love.graphics.print("2", 70, configy+160)
      love.graphics.print("3", 130, configy+160)
      love.graphics.print("4", 190, configy+160)
      love.graphics.print("5", 250, configy+160)
      love.graphics.setColor(1, 1, 1)
    end,
    
    keypressed = function(key)
      if key == "escape" and gamemode == 2 then
        gamemode = 0
      end
    end
    
  }
end

function skins(x,y)
  --skins background 
  local skinsbackgroundImage = love.graphics.newImage('Assets/gamebackground.jpg')
  
  -- font style
  local font = love.graphics.newFont('Fonts/DIMIS___.TTF', 50)
  
  --pos x,y skins
  local skinsx, skinsy = 90,15
  return {
    draw = function()
      love.graphics.draw(skinsbackgroundImage, x, y)
      grass:draw()
      dirt:draw()
      love.graphics.draw(birdimages[0], 140, skinsy+140)
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(font)
      love.graphics.print("SKINS", skinsx, skinsy)
      love.graphics.print("ESQ", 15, skinsy+140)
      love.graphics.print("DIR", 240, skinsy+140)
      love.graphics.setColor(1, 1, 1)
    end,
    
    keypressed = function(key)
      if key == "escape" and gamemode == 3 then
        gamemode = 0
      end
    end
  }
end



function love.mousepressed(x, y, button)
  menu_inicial.mousepressed(x,y,button) 
end

function love.load()
  -- game screen dimensions
  WINDOW_WIDTH = love.graphics.getWidth()
  WINDOW_HEIGHT = love.graphics.getHeight()
  
  --menu
  menu_inicial = menu(0,0)
  
  --menu config
  menu_config = config(0,0)
  
  --menu skins
  menu_skins = skins(0,0)
  
  -- colors
  skyBlue = {.43, .77, 80}
  cream = {.87, .84, .58}
  green = {.45, .74, .18}

  -- score
  score = 0
  upcomingPipe = 1
  playing = false

  -- font style
  font = love.graphics.newFont('Fonts/DIMIS___.TTF', 50)

  -- background image
  backgroundImage = love.graphics.newImage('Assets/gamebackground.jpg')
  
  --bird sprites
  birdimages = {}
  birdimages[0] = love.graphics.newImage('Assets/birddrawing.png')

  --bird sprite
  birdImage = love.graphics.newImage('Assets/birddrawing.png')

  -- pipe sprites
  pipeDown = love.graphics.newImage('Assets/Pipe-down.png')
  pipeUp = love.graphics.newImage('Assets/Pipe-up.png')

  -- score sound effect
  scoreSound = love.audio.newSource('Sound effects/score.wav', 'static')

  -- explosion sound effect
  explosionSound = love.audio.newSource('Sound effects/explosion.wav', 'static')

  -- explosion sound effect
  jumpSound = love.audio.newSource('Sound effects/jump.wav', 'static')

  -- game screen dimensions
  WINDOW_WIDTH = love.graphics.getWidth()
  WINDOW_HEIGHT = love.graphics.getHeight()

  -- requiring files
  require('Lua Files/Bird')
  require('Lua Files/Ground')
  require('Lua Files/downwardPipes')
  require('Lua Files/upwardPipes')

  -- instances
  player = createBird(birdImage)
  dirt = createGround(0, 390, 315, 60, cream)
  grass = createGround(0, 375, 315, 15, green)

  -- coroutine
  cojump = coroutine.create(player.jump, player)

  function FirstPipes()
    -- pipe variables
    local pipeSpaceYMin = -100
    local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
    pipe1 = createDownwardPipes(pipeDown, WINDOW_WIDTH, pipeSpaceY)
    pipe2 = createUpwardPipes(pipeUp, WINDOW_WIDTH, pipeSpaceY+300)
  end
  FirstPipes()

  function SecondPipes()
    -- pipe variables
    local pipeSpaceYMin = -100
    local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
    pipe3 = createDownwardPipes(pipeDown, 490, pipeSpaceY)
    pipe4 = createUpwardPipes(pipeUp, 490, pipeSpaceY+300)
  end
  SecondPipes()

end

--------------------------------------[UPDATE]------------------------------------

function love.update(dt)
  if playing then
    if pipe1.x + pipe1.width and pipe2.x + pipe2.width < 0 then
      pipe1.x = WINDOW_WIDTH
      pipe2.x = WINDOW_WIDTH
      FirstPipes()
    end

    if pipe3.x + pipe3.width and pipe4.x + pipe4.width < 0 then
      SecondPipes()
      pipe3.x = WINDOW_WIDTH
      pipe4.x = WINDOW_WIDTH
    end

    player:update(dt)
    pipe1:update(dt)
    pipe2:update(dt)
    pipe3:update(dt)
    pipe4:update(dt)

    if player:collision(pipe1) then
      love.load()
      explosionSound:play()
    elseif player:collision(pipe2) then
      love.load()
      explosionSound:play()
    elseif player:collision(pipe3) then
      love.load()
      explosionSound:play()
    elseif player:collision(pipe4) then
      love.load()
      explosionSound:play()
    elseif player:collision(grass) then
      love.load()
      explosionSound:play()
    end

    if upcomingPipe == 1 and player.x > (pipe1.x + pipe1.width) then
      score = score + 1
      upcomingPipe = 2
      scoreSound:play()
    end
    if upcomingPipe == 2 and player.x > (pipe3.x + pipe3.width) then
      score = score + 1
      upcomingPipe = 1
      scoreSound:play()
    end

    if (score > high_score) then
      high_score = score
    end
  end
end

function love.keypressed(key)
  if gamemode == 0 then
    menu_inicial.keypressed(key)
  elseif gamemode == 1 then
    if key == 'space' then
      playing = true
      coroutine.resume(cojump, player)
      jumpSound:play()
    elseif key == 'p' and playing == true then
      playing = false
    end
  elseif gamemode == 2 then
    menu_config.keypressed(key)
  elseif gamemode == 3 then
    menu_skins.keypressed(key)
  end
end
--------------------------------------[UPDATE]------------------------------------


--------------------------------------[DRAW]------------------------------------
function love.draw()
  if gamemode == 0 then
    menu_inicial.draw()
    
  elseif gamemode == 2 then
    menu_config.draw()
    
  elseif gamemode == 3 then
    menu_skins.draw()
    
  else
    love.graphics.draw(backgroundImage, 0, 0)
    pipe1:draw()
    pipe2:draw()
    pipe3:draw()
    pipe4:draw()
    player:draw()
    grass:draw()
    dirt:draw()

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font)
    love.graphics.print(score, 140, 50)
    love.graphics.print(string.format("MAX: %d",high_score), 120, 15, 0, 0.5)
    if playing == false then
      love.graphics.print("Pause", 125, 400, 0, 0.5)
    end
    
    love.graphics.setColor(1, 1, 1)
  end
  
end
--------------------------------------[DRAW]------------------------------------
