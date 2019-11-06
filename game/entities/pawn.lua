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

function pawn:receive(message)

end

function pawn:update(dt)

end

return pawn
