local pawn_prototype = require "/entities/pawn"
local player = { }
player.__index = player

function player:new(model)
    local o = pawn_prototype:new(model)
    setmetatable(o, player)
    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    o.kind = "player"
    o.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    return o
end

function player:receive(message, broadcaster)
    local side_effect = nil

    if message.name == "move" and message.agent == self then
        self.status[message.direction] = true
        local direction = pawn_prototype:get_direction(message.direction)
        side_effect = {
            name = "collide",
            agent = self,
            direction = message.direction,
            target = {
                position = {
                    x = self.position.x + direction.x,
                    y = self.position.y + direction.y
                },
                dimensions = self.dimensions
            }
        }
    elseif message.name == "stop" and message.agent == self then
        self.status[message.direction] = false
    end

    if side_effect ~= nil then
        broadcaster:broadcast(side_effect)
    end
end

function player:update(dt)
    -- TODO detect collisions here, not in the receive function
    if self.status.up then
        self.position.y = self.position.y - 1
        self.direction = "north"
    end
    if self.status.down then
        self.position.y = self.position.y + 1
        self.direction = "south"
    end
    if self.status.left then
        self.position.x = self.position.x - 1
        self.direction = "west"
    end
    if self.status.right then
        self.position.x = self.position.x + 1
        self.direction = "east"
    end
end

return player
