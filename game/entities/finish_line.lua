local Entity = require "/entities/base/entity"

local function FinishLine(world, model)
    local self = Entity(world, model)
    self.color = {
        255, -- red
        255, -- green
        255, -- blue
        0.5, -- alpha
    }

    self.body = love.physics.newBody(world, model.x, model.y, "static")
    self.shape = love.physics.newRectangleShape(model.w, model.h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 100)

    function self:update(dt, controller)
        if self.body:isTouching(controller.player.body) then
            print("level has finished!")
            controller.broadcaster:broadcast({
                name = "finish"
            })
        end
    end

    return self
end

return FinishLine
