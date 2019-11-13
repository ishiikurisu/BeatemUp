local Pawn = require "models/pawn"
local signals_directions = require "/signals/directions"

local function Player(world, model)
    local self = Pawn(world, model)

    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    self.kind = "player"
    self.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    self.status = {
        up = false,
        down = false,
        left = false,
        right = false
    }

    function self:receive(message, controller)
        local direction = nil

        if message.agent == self then
            if message.name == "move" then
                self.status[message.direction] = true
            elseif message.name == "stop" then
                self.status[message.direction] = false
            end
        end
    end

    function self:update(dt, controller)
        local vx = 0
        local vy = 0
        for key, value in pairs(self.status) do
            if value == true then
                local direction = signals_directions.get_direction(key)
                vx = vx + 100 * direction.x
                vy = vy + 100 * direction.y
            end
        end
        self.body:setLinearVelocity(vx, vy)
    end

    return self
end

return Player
