local geometry_prototype = require "/entities/geometry"
local brick = { }
brick.__index = brick

function brick:new(model)
    local o = geometry_prototype:new(model)
    setmetatable(o, brick)
    o.color = {
        255, -- red
        255, -- green
        255  -- blue
    }
    return o
end

function brick:receive(message)

end

function brick:update(dt)

end

return brick
