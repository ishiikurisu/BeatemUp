local signals_directions = require "/signals/directions"
local player = { }
player.__index = player

function player:new(world, model)
    local o = { }
    setmetatable(o, player)

    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    o.kind = "player"
    o.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    o.status = {
        up = false,
        down = false,
        left = false,
        right = false
    }

    o.body = love.physics.newBody(world, model.x, model.y, "dynamic")
    o.shape = love.physics.newRectangleShape(model.w, model.h)
    o.fixture = love.physics.newFixture(o.body, o.shape, 5)

    return o
end

function player:receive(message, controller)
    local direction = nil

    if message.agent == self then
        if message.name == "move" then
            self.status[message.direction] = true
        elseif message.name == "stop" then
            self.status[message.direction] = false
        end
    end
end

function player:update(dt, controller)
    local vx = 0
    local vy = 0
    for key, value in pairs(self.status) do
        if value == true then
            local direction = signals_directions.get_direction(key)
            vx = vx + 100 * direction.x
            vy = vy + 100 * direction.y
        end
    end
    self.body:setLinearVelocity(vx, vy)
    -- TODO prevent pawns from spinning after colliding
end

return player
