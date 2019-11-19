local Pawn = require "entities/base/pawn"

local function Enemy(world, model)
    local self = Pawn(world, model)
    self.kind = "enemy"
    self.color = {
        0,    -- red
        255,  -- green
        0,    -- blue
        1,    -- alpha
    }
    self.followRange =  model.followRange
    self.attackRange =  model.attackRange
    self.velocity = 100

    function self:receive(message, controller)
        self:processMovementMessages(message, controller)
    end

    function self:update(dt, controller)
        -- checking if should act
        local distance = self:getDistance(controller.player)

        if distance < self.followRange and distance > self.attackRange then
            -- TODO get directions from player and move there
        elseif distance < self.attackRange then
            -- TODO implement me!
        else
            for direction, _ in pairs(self.status) do
                controller.broadcaster:broadcast({
                    name = "stop",
                    agent = self,
                    direction = direction
                })
            end
        end

        -- applying physics natural effects
        self:move(dt, controller)
    end

    return self
end

return Enemy
