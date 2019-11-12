local enemy = { }
enemy.__index = enemy

function enemy:new(world, model)
    local o = { }
    setmetatable(o, enemy)
    o.color = {
        0,    -- red
        255,  -- green
        0     -- blue
    }

    o.body = love.physics.newBody(world, model.x, model.y, "dynamic")
    o.shape = love.physics.newRectangleShape(model.w, model.h)
    o.fixture = love.physics.newFixture(o.body, o.shape, 1)

    return o
end

function enemy:receive(message, controller)

end

function enemy:update(dt, controller)
    -- TODO make this guy follow the player
    -- TODO attack player if they are too close
end

return enemy
