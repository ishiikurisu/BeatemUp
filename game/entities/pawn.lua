local geometry_prototype = require "/entities/geometry"
local pawn = { }
pawn.__index = pawn

function pawn:new(model)
    local o = geometry_prototype:new(model)
    setmetatable(o, pawn)
    return o
end

function pawn:receive(message)

end

function pawn:update(dt)

end

return pawn
