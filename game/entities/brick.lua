local brick = { }
brick.__index = brick

function brick:new(world, model)
    local o = { }
    setmetatable(o, brick)
    o.color = {
        255, -- red
        255, -- green
        255  -- blue
    }

    o.body = love.physics.newBody(world, model.x, model.y, "static")
    o.shape = love.physics.newRectangleShape(model.w, model.h)
    o.fixture = love.physics.newFixture(o.body, o.shape, 100)
    return o
end


function brick:receive(message, controller)

end


function brick:update(dt, controller)

end

return brick
