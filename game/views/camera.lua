local function Camera()
    local self = { }
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.w = 300
    self.h = 200

    -- util functions

    function self:containsPlayer(playerX, playerY, cameraX, cameraY)
        local x = (playerX >= (cameraX - (self.w / 2))) and
                  (playerX <= (cameraX + (self.w / 2)))
        local y = (playerY >= (cameraY - (self.h / 2))) and
                  (playerY <= (cameraY + (self.h / 2)))
        return x and y
    end

    -- debug functions

    function self:debug(playerX, playerY, cameraX, cameraY)
        print("---")
        print("player:")
        print("  x: " .. playerX)
        print("  y: " .. playerY)
        print("camera:")
        print("  x: " .. cameraX)
        print("  y: " .. cameraY)
    end

    function self:debugOutsideCamera(theta, dx, dy, isOutside)
        local outside = "nope"
        if isOutside then
            outside = "yep"
        end

        print("outside?: " .. outside)
        print("theta: " .. theta)
        print("dx: " .. dx)
        print("dy: " .. dy)
    end

    ---------------------------------------------------------------------------
    -- Displays camera block in the screen. should be called inside `love.draw`
    ---------------------------------------------------------------------------
    function self:showCamera()
        local cameraX, cameraY = love.graphics.inverseTransformPoint(self.x, self.y)
        local w = self.w
        local h = self.h
        local x = cameraX - w / 2
        local y = cameraY - h / 2

        love.graphics.setColor(255, 255, 255, 0.5)
        love.graphics.rectangle("fill", x, y, w, h)
    end

    ---------------------------------------------------------------------------
    -- the camera only moves if the player is outside the camera. if that is
    -- the case, then the camera moves so slightly as to make the player
    -- visible. the camera is a fixed rectangle in the middle of the screen
    ---------------------------------------------------------------------------
    -- @param player the player pawn
    ---------------------------------------------------------------------------
    function self:follow(player)
        -- getting required coordinates
        local translationX, translationY = 0, 0
        local cameraX, cameraY = love.graphics.inverseTransformPoint(self.x, self.y)
        local playerX, playerY = love.graphics.transformPoint(
            player.body:getX(),
            player.body:getY()
        )

        -- calculating required movement parameters
        local isOutside = not self:containsPlayer(playerX, playerY, cameraX, cameraY)
        local theta = math.atan((playerY - cameraY) / (playerX - cameraX))
        local dx, dy = 0, 0

        if theta > math.pi / 4 then
            dy = self.h / 2
            dx = dy * (playerX - cameraX) / (playerY - cameraY)
        else
            dx = self.w / 2
            dy = dx * (playerY - cameraY) / (playerX - cameraX)
        end

        -- move camera if required
        local distance = ((playerX - cameraX)^2 + (playerY - cameraY)^2) ^ 0.5
        if isOutside then
            local translationX = (cameraRadius - distance) * (playerX - cameraX) / distance
            local translationY = (cameraRadius - distance) * (playerY - cameraY) / distance
            love.graphics.translate(translationX, translationY)
        end
    end

    return self
end

return Camera
