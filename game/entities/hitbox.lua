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
    self.concept = true  -- change this to false whenever you want to see hitboxes
    self.agent = model.agent

    function self:update(dt, controller)
        self.lifespan = self.lifespan - dt
        if self.lifespan < 0 then
            controller:destroy(self)
            return controller
        end

        for entity, _ in pairs(controller.entities) do
            local not_me = entity ~= self
            local healthy_entity = entity.health
            local is_touching = entity.body and self.body:isTouching(entity.body)

            if not_me and healthy_entity and is_touching then
                controller.broadcaster:broadcast({
                    name = "hurt",
                    agent = self.agent,
                    target = entity,
                }, controller)
            end
        end
    end

    return self
end

return Hitbox
