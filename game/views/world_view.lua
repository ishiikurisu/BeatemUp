local function WorldView()
    local self = { }
    local black = { 0, 0, 0 }

    local cameraRadius = 250
    self.translationX = 0
    self.translationY = 0

    function self:draw(controller)
        -- CENTERING CAMERA
        local playerX, playerY = love.graphics.transformPoint(
            controller.player.body:getX(),
            controller.player.body:getY()
        )
        local cameraX, cameraY = love.graphics.inverseTransformPoint(
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2
        )
        local distance = ((playerX - cameraX)^2 + (playerY - cameraY)^2) ^ 0.5
        if distance > cameraRadius then
            self.translationX = cameraX - playerX
            self.translationY = cameraY - playerY
        end

        -- TODO make camera follow player instead of simply moving to the player position
        love.graphics.translate(self.translationX, self.translationY)

        -- DRAWING STUFF
        love.graphics.setBackgroundColor(black)

        for _, entity in pairs(controller.entities) do
            local r = entity.color[1]
            local g = entity.color[2]
            local b = entity.color[3]
            love.graphics.setColor(r, g, b)
            love.graphics.polygon("fill", entity.body:getWorldPoints(entity.shape:getPoints()))
        end
    end

    return self
end

return WorldView
