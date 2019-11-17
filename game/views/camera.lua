local function Camera()
    local self = { }

    ---------------------------------------------------------------------------
    -- the camera only moves if the player is outside the camera. if that is
    -- the case, then the camera moves so slightly as to make the player
    -- visible. the camera is a fixed rectangle in the middle of the screen
    ---------------------------------------------------------------------------
    -- @param player the player pawn
    ---------------------------------------------------------------------------
    function self:follow(player)
        love.graphics.translate(-player.body:getX(), -player.body:getY())  -- follow player
        love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)  -- center player in screen
    end

    return self
end

return Camera
