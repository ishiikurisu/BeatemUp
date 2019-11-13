local Pawn = { }

local function Pawn(world, model)
    local self = { }
    self.color = {
        0,  -- red
        0,  -- green
        0   -- blue
    }

    self.body = love.physics.newBody(world, model.x, model.y, "dynamic")
    self.shape = love.physics.newRectangleShape(model.w, model.h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.body:setAngularDamping(10000)

    function self:receive(message, controller)
    end

    function self:update(dt, controller)
    end

    return self
end

local function Pawn:update(dt, controller)

end

return Pawn
