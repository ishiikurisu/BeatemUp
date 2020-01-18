local Camera = require "views/camera"

local function WorldView()
    local self = { }
    local black = { 0, 0, 0 }
    local green = { 0, 1, 0, 0.3 }
    local red = { 1, 0, 0, 0.3 }
    self.camera = Camera()
    self.debug = false

    function self:drawHealthBar(entity)
        if entity.health then
            -- healthy part
            local healthyW = 75 * entity.health / entity.totalHealth
            local healthyH = 10
            local healthyX = entity.body:getX() - 75 / 2
            local healthyY = entity.body:getY() - 70
            local healthyT = entity:getHealthDecay()
            love.graphics.setColor(green[1], green[2], green[3], healthyT)
            love.graphics.rectangle("fill", healthyX, healthyY, healthyW, healthyH)

            -- unhealthy part
            local unhealthyW = 75 * (1 - entity.health / entity.totalHealth)
            local unhealthyH = healthyH
            local unhealthyX = entity.body:getX() - 75 / 2 + healthyW
            local unhealthyY = healthyY
            local unhealthyT = healthyT
            love.graphics.setColor(red[1], red[2], red[3], unhealthyT)
            love.graphics.rectangle("fill", unhealthyX, unhealthyY, unhealthyW, unhealthyH)
        end
    end

    self.sortEntities = function(a, b)
        local az = a.view.z
        local bz = b.view.z
        if az == bz then
            local ay = a.body:getY()
            local by = b.body:getY()
            if ay == by then
                return a.body:getX() < a.body:getX()
            end
            return ay < by
        end
        return az < bz
    end

    function self:drawEntites(controller)
        -- TODO sort entities in the same Z position by their Y axis
        -- TODO sort entities in the same Y position by their X axis
        local entities = { }
        for entity, _ in pairs(controller.entities) do
            if not entity.concept and entity.view and entity.view.drawable then
                table.insert(entities, entity)
            end
        end
        table.sort(entities, self.sortEntities)

        -- drawing entities
        for _, entity in pairs(entities) do
            entity.view:draw(entity)
            self:drawHealthBar(entity)
        end
    end

    function self:drawDebug(controller)
        love.graphics.setBackgroundColor(black)

        for entity, _ in pairs(controller.entities) do
            -- drawing hitbox
            if not entity.concept then
                local r = entity.color[1]
                local g = entity.color[2]
                local b = entity.color[3]
                local a = entity.color[4]
                love.graphics.setColor(r, g, b, a)
                love.graphics.polygon("fill", entity.body:getWorldPoints(entity.shape:getPoints()))
            end
            self:drawHealthBar(entity)
        end
    end

    function self:draw(controller)
        self.camera:follow(controller.player)

        if self.debug then
            self:drawDebug(controller)
        end
        self:drawEntites(controller)
    end

    return self
end

return WorldView
