local Camera = require "views/camera"

local function WorldView()
    local self = { }
    local black = { 0, 0, 0 }
    local green = { 0, 1, 0, 0.3 }
    local red = { 1, 0, 0, 0.3 }
    self.camera = Camera()

    function self:draw(controller)
        self.camera:follow(controller.player)

        love.graphics.setBackgroundColor(black)

        for entity, _ in pairs(controller.entities) do
            if not entity.concept then
                local r = entity.color[1]
                local g = entity.color[2]
                local b = entity.color[3]
                local a = entity.color[4]
                love.graphics.setColor(r, g, b, a)
                love.graphics.polygon("fill", entity.body:getWorldPoints(entity.shape:getPoints()))
            end

            if entity.health then
                -- healthy part
                local healthyW = 75 * entity.health / entity.totalHealth
                local healthyH = 10
                local healthyX = entity.body:getX() - 75 / 2
                local healthyY = entity.body:getY() - 70
                local healthyT = 0.3  -- TODO  make health bar transparent as time passes
                love.graphics.setColor(green[1], green[2], green[3], healthyT)
                love.graphics.rectangle("fill", healthyX, healthyY, healthyW, healthyH)

                -- unhealthy part
                local unhealthyW = 75 * (1 - entity.health / entity.totalHealth)
                local unhealthyH = 10
                local unhealthyX = entity.body:getX() - 75 / 2 + healthyW
                local unhealthyY = entity.body:getY() - 70
                local unhealthyT = 0.3
                love.graphics.setColor(red[1], red[2], red[3], unhealthyT)
                love.graphics.rectangle("fill", unhealthyX, unhealthyY, unhealthyW, unhealthyH)
            end
        end
    end

    return self
end

return WorldView
