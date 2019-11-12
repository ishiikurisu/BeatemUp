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
    if message.name == "move" and message.agent == self then
        self.status[message.direction] = true
    elseif message.name == "stop" and message.agent == self then
        self.status[message.direction] = false
    end
end

function player:update(dt, broadcaster)
    local directions = { }

    if self.status.up then
        self.direction = "north"
        self.position.y = self.position.y - 1
        table.insert(directions, "north")
    end
    if self.status.down then
        self.position.y = self.position.y + 1
        self.direction = "south"
        table.insert(directions, "south")
    end
    if self.status.left then
        self.position.x = self.position.x - 1
        self.direction = "west"
        table.insert(directions, "west")
    end
    if self.status.right then
        self.position.x = self.position.x + 1
        self.direction = "east"
        table.insert(directions, "east")
    end

    for _, direction in pairs(directions) do
        broadcaster:broadcast({
            name = "collide",
            agent = self,
            direction = pawn_prototype:get_direction(direction),
            target = {
                position = {
                    x = self.position.x,
                    y = self.position.y
                },
                dimensions = self.dimensions
            }
        })
    end
end

return player
