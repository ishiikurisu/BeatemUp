local Entity = require "entities/base/entity"

local function Hitbox(world, model)
    local self = Entity(world, model)
    self.color = {
        255,  -- red
        255,  -- green
        255,   -- blue
        0.3   -- alpha
    }

    self.body = love.physics.newBody(world, model.x, model.y, "static")
    self.shape = love.physics.newRectangleShape(model.w, model.h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 100)
    self.lifespan = model.lifespan
    self.concept = false  -- XXX change this to false whenever you want to see hitboxes

    function self:update(dt, controller)
        self.lifespan = self.lifespan - dt
        if self.lifespan < 0 then
            controller.entities[self] = nil
            self.fixture:destroy()
        end
    end

    return self
end

return Hitbox
