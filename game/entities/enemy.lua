local pawn_prototype = require "/entities/pawn"
local enemy = { }
enemy.__index = enemy

function enemy:new(model)
    -- TODO create template for pawns since both players and enemies have many stuff in common
    local o = pawn_prototype:new(model)
    setmetatable(o, enemy)
    o.color = {
        0,    -- red
        255,  -- green
        0     -- blue
    }
    return o
end

function enemy:receive(message, broadcaster)

end

function enemy:update(dt)

end

return enemy
