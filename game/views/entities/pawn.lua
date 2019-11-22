local function PawnView(spriteFolder)
    local self = { }
    self.z = 1
    -- TODO load sprite sheet
    self.drawable = false
    if spriteFolder then
        self.sprites = {
            stillRight = love.graphics.newImage("/assets/sprites/pawns/" .. spriteFolder .. "/StillRight.png"),
            -- TODO get remaining sprites
        }
        self.drawable = true
    end

    function self:getCoordinates(model)
        return {
            z = self.z,
            y = model.body:getY(),
            x = model.body:getX(),
        }
    end

    function self:draw(entity)
        -- TODO get current state
        local sprite = self.sprites.stillRight

        -- TODO draw sprite according to entity's body and frame
        -- TODO correct X and Y according to sprite size
        local x = entity.body:getX() - 25
        local y = entity.body:getY() - 40
        love.graphics.draw(sprite, x, y)
    end

    return self
end

return PawnView
