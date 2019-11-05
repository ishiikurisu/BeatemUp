local world_view = { }
world_view.__index = world_view

function world_view:new()
    local o = { }
    setmetatable(o, world_view)
    return o
    end

function world_view:draw(controller)
    -- TODO implement me!
end

return world_view
