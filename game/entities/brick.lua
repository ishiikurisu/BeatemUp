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

function collideX(a, b)
    local bx = tonumber(b.position.x)
    local ax = tonumber(a.position.x)
    local bw = tonumber(b.dimensions.w) / 2
    local aw = tonumber(a.dimensions.w) / 2
    local a0 = ax - aw
    local a1 = ax + aw
    local b0 = bx - bw
    local b1 = bx + bw
    return ((a0 <= b0) and (a1 >= b0)) or ((a0 <= b1) and (a1 >= b1))
end

function collideY(a, b)
    local by = tonumber(b.position.y)
    local ay = tonumber(a.position.y)
    local bh = tonumber(b.dimensions.h) / 2
    local ah = tonumber(a.dimensions.h) / 2
    local a0 = ay - ah
    local a1 = ay + ah
    local b0 = by - bh
    local b1 = by + bh
    return ((a0 <= b0) and (a1 >= b0)) or ((a0 <= b1) and (a1 >= b1))
end

function collide(a, b)
    return collideX(a, b) and collideY(a, b)
end

function brick:receive(message, broadcaster)
    if message.name == "collide" then
        local is_collision = collide(self, message.target)
        if is_collision then
            broadcaster:broadcast({
                name = "stop",
                agent = message.agent,
                direction = message.direction
            })
        end
    end
end


function brick:update(dt)

end

return brick
