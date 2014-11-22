--
-- Shinney!
--


local log = require 'log'


function love.load()

    log.info("starting up")

    love.window.setMode(800, 600, {fullscreen=false, resizable=true, vsync=false, minwidth=400, minheight=300})

    -- Sprites
    image = love.graphics.newImage("assets/sprite.jpg")

    -- Create our world.
    world = love.physics.newWorld(0, 0, true)

    ground = love.physics.newBody(world, 0, 0, "static")

    -- Create the ground shape at (400,500) with size (600,10).
    ground_shape = love.physics.newRectangleShape( 400, 500, 600, 10)

    -- Create fixture between body and shape
    ground_fixture = love.physics.newFixture( ground, ground_shape)
end

function love.keypressed(key, unicode)
    log.info("Keypressed %s", key)
end

-- Update the date of the world.
function love.update(dt)
    world:update(dt)
end


function love.draw()
    -- Draws the ground.
    love.graphics.polygon("line", ground:getWorldPoints(ground_shape:getPoints()))


    -- Instructions
    love.graphics.print("space: Apply a random impulse",5,5)
end
