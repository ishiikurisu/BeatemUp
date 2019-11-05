local player = { }
player.__index = player

function player:new()
    local o = { }
    setmetatable(o, broadcaster)
    o.position = {
        x = 400,
        y = 400
    }
    o.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    return o
end

function player:receive(message)

end

return player
