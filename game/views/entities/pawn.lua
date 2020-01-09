local function listAllSprites(spriteFolder)
    local sprites = { }
    local sourceFolder = "/assets/sprites/pawns/" .. spriteFolder
    local folders = love.filesystem.getDirectoryItems(sourceFolder)

    for _, position in pairs(folders) do
        local positionFolder = sourceFolder .. "/" .. position .. "/"
        local frames = love.filesystem.getDirectoryItems(positionFolder)
        sprites[position] = { }
        for _, frame in pairs(frames) do
            local imagePath = positionFolder .. frame
            local image = love.graphics.newImage(imagePath)
            table.insert(sprites[position], image)
        end
    end

    return sprites
end

local function PawnView(spriteFolder)
    local self = { }
    self.z = 1
    -- TODO load sprite sheet
    self.drawable = false
    self.sprites = { }
    self.frame = 1
    self.subFrame = 1
    self.lastState = nil
    if spriteFolder then
        self.sprites = listAllSprites(spriteFolder)
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
        -- possible states:
        -- - still
        -- - walking
        -- - punching
        -- - punched
        local state = entity:getDrawableState()
        local direction = "Right"
        if entity.face < 0 then
            direction = "Left"
        end
        local template = state .. direction
        local sprite = self.sprites[template][self.frame]

        -- TODO draw sprite according to entity's body and frame
        -- TODO correct X and Y according to sprite size
        local x = entity.body:getX() - 25
        local y = entity.body:getY() - 40
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(sprite, x, y)

        -- updating frame
        if state == self.lastState then
            self.subFrame = self.subFrame + 1
            if self.subFrame >= 13 then
                if self.frame == #self.sprites[template] then
                    self.frame = 1
                else
                    self.frame = self.frame + 1
                end
                self.subFrame = 1
            end
        else
            self.subFrame = 1
            self.frame = 1
        end
        self.lastState = state
    end

    return self
end

return PawnView
