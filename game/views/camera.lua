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
        love.graphics.translate(self.translationX, self.translationY)

        -- getting required coordinates
        local translationX, translationY = 0, 0
        local cameraX, cameraY = love.graphics.inverseTransformPoint(self.x, self.y)
        local playerX, playerY = love.graphics.transformPoint(
            player.body:getX(),
            player.body:getY()
        )

        -- move camera if player is outside it
        if not self:containsPlayer(playerX, playerY, cameraX, cameraY) then
            -- radius, as in the distance between the camera center and its boundaries
            local rx, ry = 0, 0
            -- distance, as in the distance between the player and the camera
            local dx, dy = playerX - cameraX, playerY - cameraY
            local theta = math.atan(playerY - cameraY, playerX - cameraX)

            -- FIXME the second parameter depends on the quadrant to which theta is related to
            -- FIXME and the actual angle for the camera rectangle makes

            local la = math.atan(self.h, self.w)  -- limit angle
            if math.abs(theta) > la then
                ry = self.h / 2
                rx = ry * dx / dy
            else
                rx = self.w / 2
                ry = rx * dy / dx
            end

            local translationX = (rx - dx) * math.cos(theta)
            local translationY = (ry - dy) * math.sin(theta)
            love.graphics.translate(translationX, translationY)
        end

        self.translationX = self.translationX + translationX
        self.translationY = self.translationY + translationY
    end

    return self
end

return Camera
