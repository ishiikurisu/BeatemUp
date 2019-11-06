local brick = { }
brick.__index = brick

function brick:new(model)
    -- TODO create template for pawns since both players and enemies have many stuff in common
    local o = { }
    setmetatable(o, brick)
    o.position = {
        x = model.x,
        y = model.y
    }
    o.dimensions = {
        w = model.w,
        h = model.h
    }
    o.color = {
        255, -- red
        255,   -- green
        255    -- blue
    }
    return o
end

function brick:receive(message)

end

function brick:update(dt)

end

return brick
