local Pawn = require "models/pawn"

local function Enemy(world, model)
    local self = Pawn(world, model)
    self.color = {
        0,    -- red
        255,  -- green
        0     -- blue
    }

    function self:receive(message, controller)
    end

    function self:update(dt, controller)
        -- TODO make this guy follow the player
        -- TODO attack player if they are too close
        -- TODO apply some friction to this guy
    end


    return self
end

return Enemy
