local world_view = { }
world_view.__index = world_view

function world_view:new()
    local o = { }
    setmetatable(o, world_view)
    return o
    end

function world_view:draw(controller)
    local black = { 0, 0, 0 }

    -- TODO draw level
    love.graphics.setBackgroundColor(black)

    -- TODO draw entities

    -- drawing player
    local x = controller.player.position.x + 5
    local y = controller.player.position.y + 5
    local width = 10
    local height = 10
    love.graphics.setColor(controller.player.color)
    love.graphics.rectangle("fill", x, y, width, height)
end

return world_view
