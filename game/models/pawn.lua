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
    self.friction = 0.3

    function self:receive(message, controller)
    end

    function self:update(dt, controller)
    end

    function self:apply_friction(dt)
        local vx, vy = self.body:getLinearVelocity()
        vx = vx * (1 - self.friction)
        vy = vy * (1 - self.friction)
        self.body:setLinearVelocity(vx, vy)
    end

    return self
end

return Pawn
