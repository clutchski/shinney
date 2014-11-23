--
-- Shinney!
--


local log   = require 'log'
local model = require 'model'


function love.load()
    log.infof("starting up")

    -- set window mode.
    love.window.setMode(1920, 1080, {
        fullscreen=false,
        resizable=true,
        vsync=false,
        minwidth=400,
        minheight=300,
    })

    --
    love.graphics.setBackgroundColor(240, 245, 245)

    -- Create our world.
    world = love.physics.newWorld(0, 0, true)

    puck = model.Puck.new(world)
    player = model.Player.new(world)

    puck:setPlayer(player)
end

function love.keypressed(key, unicode)
    log.debugf("Keypressed %s", key)
    if key == 'q' then
      log.infof("farewell")
      love.event.quit()
    end
end

-- Update the date of the world.
function love.update(dt)
    isDown = love.keyboard.isDown

    -- Calculate if we're skating or not.
    dx = 0
    dy = 0

    if isDown("right") then
        dx = dx + 1
    elseif isDown("left") then
        dx = dx - 1
    end

    if isDown("up") then
        dy = dy - 1
    elseif isDown("down") then
        dy = dy + 1
    end
    player:skate(dx, dy)

    -- update the puck position (if a player is controlling it)
    puck:update()

    world:update(dt)
end

function love.draw()
  puck:draw()
  player:draw()
end
