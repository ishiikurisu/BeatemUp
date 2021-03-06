local Pawn = require "entities/base/pawn"

local function Player(world, model)
    local self = Pawn(world, model)

    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    self.kind = "player"
    self.color = {
        255, -- red
        0,   -- green
        0,   -- blue
        1,   -- alpha
    }

    function self:receive(message, controller)
        self:processHits(message, controller)
        self:processMovementMessages(message, controller)

        if message.name == 'attack' and message.agent == self then
            self:hit(controller)
        end
    end

    function self:update(dt, controller)
        self:applyBodyFunctions(dt, controller)
        self:move(dt, controller)
    end

    return self
end

return Player
