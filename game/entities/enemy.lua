local Pawn = require "entities/base/pawn"

local function Enemy(world, model)
    local self = Pawn(world, model)
    self.color = {
        0,    -- red
        255,  -- green
        0,    -- blue
        1,    -- alpha
    }
    self.followRange =  model.followRange
    self.attackRange =  model.attackRange

    function self:receive(message, controller)
    end

    function self:update(dt, controller)
        local distance = self:getDistance(controller.player)

        if distance < self.followRange and distance > self.attackRange then
            -- TODO make this guy follow the player
            print("I will follow!")
        elseif distance < self.attackRange then
            -- TODO attack player if they are too close
            print("I will attack!")
        end

        -- physics natural effects
        self:apply_friction(dt)
    end

    return self
end

return Enemy
