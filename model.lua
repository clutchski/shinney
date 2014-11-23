
local log = require 'log'

--
-- Player
--


local Player = {}
Player.__index = Player

function Player.new(world)
    log.infof("Creating puck")
    local self = setmetatable({}, Player)


    self.img = love.graphics.newImage("assets/images/player.png")
    w, h = self.img:getDimensions()
    log.infof("got image %d %d", w, h)

    self.b = love.physics.newBody(world, 0, 0, "dynamic")
    self.s = love.physics.newRectangleShape(self.img:getWidth(), self.img:getHeight())
    self.f = love.physics.newFixture(self.b, self.s)

    self.b:setLinearDamping(0.9)
    self.b:setMassData(0, 0, 5, 0)

    self.speed = 9000

    return self
end

function Player:skate(x, y)

    speed = self.speed

    -- if this is a change in direction, increase the power of the force
    -- to simulate the skates cutting into the ice so we stop faster
    -- then we accelerate.
    stopForce = 2.5
    if self:isStopping(x, y) then
        speed = speed * stopForce
    end

    if x > 0 and y > 0 then
        speed = speed / 2
    end

    -- are we changing direction? do it harder
    self.b:applyForce(speed * x, self.speed * y)
end

-- Return the x, y co-ordinates of the player's stick (i.e. where the puck
-- would be if the player has it)
function Player:getStickPosition()
    return self.b
end

function Player:isStopping(dx, dy)
    vx, vy = self.b:getLinearVelocity()
    return ((vx < 0 and dx > 0) or
            (vx > 0 and dx < 0) or
            (vy < 0 and dy > 0) or
            (vy > 0 and dy < 0))
end

function Player:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.img, self.b:getX(), self.b:getY(), self.b:getAngle(),  1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end

--
-- Puck
--

local Puck = {}
Puck.__index = Puck

function Puck.new(world)
    log.infof("Creating puck")
    local self = setmetatable({}, Puck)

    self.b = love.physics.newBody(world, 0, 0, "dynamic")
    self.s = love.physics.newCircleShape(5)
    self.f = love.physics.newFixture(self.b, self.s)

    -- the player who's in possession of the puck
    self.player = nil

    return self
end

function Puck:getPlayer()
    return self.player
end

function Puck:setPlayer(player)
    self.player = player

end

function Puck:update()
    if self.player == nil then
        return
    end
    -- position the puck on the stick
    x, y = self.player.b:getPosition()

    self.b:setPosition(x + 50, y + 50)
end



function Puck:draw()
    love.graphics.setColor(3, 3, 3)
    love.graphics.circle(
        "fill",
        self.b:getX(),
        self.b:getY(),
        self.s:getRadius(),
        36)
end

--
-- Rink
--

local Rink = {}
Rink.__index = Rink

function Rink.new(world)
    log.infof("Creating rink")
    local self = setmetatable({}, Rink)

    self.body = love.physics.newBody(world, 450/2, 450-50/2)
    self.shape = love.physics.newRectangleShape(450, 50)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    return self
end

function Rink:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end

-- export everything
local model = {}

model.Rink = Rink
model.Puck = Puck
model.Player = Player

return model
