local Camera = require "views/camera"

local function WorldView()
    local self = { }
    local black = { 0, 0, 0 }
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
        end
    end

    return self
end

return WorldView
