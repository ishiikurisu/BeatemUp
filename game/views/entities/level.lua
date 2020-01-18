local function LevelView(spriteFolder)
    local self = { }
    self.z = 0
    self.drawable = false
    if spriteFolder then
        self.sprites = {
            background = love.graphics.newImage("/assets/sprites/worlds/" .. spriteFolder .. "/background.png")
        }
        self.drawable = true
    end

    function self:draw(entity)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.sprites.background, 0, 0)
    end

    return self
end

return LevelView
