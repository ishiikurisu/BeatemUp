local pawn_prototype = require "/entities/pawn"
local player = { }
player.__index = player

function player:new(model)
    local o = pawn_prototype:new(model)
    setmetatable(o, player)
    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    o.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    return o
end

function player:receive(message)
    -- TODO detect colisions
    if message.action == "start moving up" then
        self.status.up = true
        self.status.down = false
    elseif message.action == "stop moving up" then
        self.status.up = false
    elseif message.action == "start moving left" then
        self.status.left = true
        self.status.right = false
    elseif message.action == "stop moving left" then
        self.status.left = false
    elseif message.action == "start moving down" then
        self.status.down = true
        self.status.up = false
    elseif message.action == "stop moving down" then
        self.status.down = false
    elseif message.action == "start moving right" then
        self.status.right = true
        self.status.left = false
    elseif message.action == "stop moving right" then
        self.status.right = falses
    end
end

function player:update(dt)
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
