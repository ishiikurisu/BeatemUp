local Pawn = require "entities/base/pawn"

local function Enemy(world, model)
    local self = Pawn(world, model)
    self.kind = "enemy"
    self.color = {
        0,    -- red
        255,  -- green
        0,    -- blue
        1,    -- alpha
    }
    self.followRange =  model.followRange
    self.attackRange =  model.attackRange
    self.staminaRange = model.staminaRange
    self.velocity = 150

    function self:receive(message, controller)
        self:processHits(message, controller)
        self:processMovementMessages(message, controller)
    end

    function self:update(dt, controller)
        -- checking if should act
        local distance, directions = self:getDirections(controller.player)
        for direction, flag in pairs(directions) do
            local message = "stop"
            if flag then
                message = "move"
            end
            controller.broadcaster:broadcast({
                name = message,
                agent = self,
                direction = direction
            }, controller)
        end
        if distance < self.attackRange then
            self:hit(controller)
        end

        -- applying natural effects
        self:applyBodyFunctions(dt, controller)
        self:move(dt, controller)
    end

    function self:getDirections(pawn)
        local distance = self:getDistance(pawn)
        local distanceX =  self.body:getX() - pawn.body:getX()
        local distanceY =  self.body:getY() - pawn.body:getY()
        local angleX = distanceX / distance
        local angleY = distanceY / distance
        local directions = {
            up = false,
            down = false,
            left = false,
            right = false
        }

        if distance < self.followRange and distance > self.attackRange then
            if angleY > 0.6 then
                directions.up = true
            end
            if angleY < -0.6 then
                directions.down = true
            end
            if angleX > 0.6 then
                directions.left = true
            end
            if angleX < -0.6 then
                directions.right = true
            end
        end

        return distance, directions
    end

    return self
end

return Enemy
