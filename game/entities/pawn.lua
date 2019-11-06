local geometry_prototype = require "/entities/geometry"
local pawn = { }
pawn.__index = pawn

function pawn:new(model)
    local o = geometry_prototype:new(model)
    setmetatable(o, pawn)
    o.status = {
        up = false,
        down = false,
        right = false,
        left = false
    }
    o.direction = "south"
    return o
end

function pawn:receive(message, broadcaster)

end

function pawn:update(dt)

end

function pawn:get_direction(direction)
    local x = 0
    local y = 0

    if direction == "up" then
        y = -1
    end
    if direction == "down" then
        y = 1
    end
    if direction == "left" then
        x = -1
    end
    if direction == "right" then
        x = 1
    end

    return {
        x = x,
        y = y
    }
end

return pawn
