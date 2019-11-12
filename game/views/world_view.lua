local world_view = { }
world_view.__index = world_view

function world_view:new()
    local o = { }
    setmetatable(o, world_view)
    return o
    end

function world_view:draw(controller)
    local black = { 0, 0, 0 }

    -- TODO implement camera

    love.graphics.setBackgroundColor(black)

    for _, entity in pairs(controller.entities) do
        local r = entity.color[1]
        local g = entity.color[2]
        local b = entity.color[3]
        love.graphics.setColor(r, g, b)
        love.graphics.polygon("fill", entity.body:getWorldPoints(entity.shape:getPoints()))
    end
end

return world_view
