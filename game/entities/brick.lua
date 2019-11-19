local Entity = require "/entities/base/entity"

local function Brick(world, model)
    local self = Entity(world, model)
    self.color = {
        255, -- red
        255, -- green
        255, -- blue
        1,   -- alpha
    }

    self.body = love.physics.newBody(world, model.x, model.y, "static")
    self.shape = love.physics.newRectangleShape(model.w, model.h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 100)

    function self:receive(message, controller)

    end

    function self:update(dt, controller)

    end

    return self
end




return Brick
