local enemy = { }
enemy.__index = enemy

function enemy:new(model)
    -- TODO create template for pawns since both players and enemies have many stuff in common
    local o = { }
    setmetatable(o, enemy)
    o.position = {
        x = model.x,
        y = model.y
    }
    o.color = {
        0, -- red
        255,   -- green
        0    -- blue
    }
    return o
end

function enemy:receive(message)

end

function enemy:update(dt)

end

return enemy
