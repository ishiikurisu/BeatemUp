local Entity = require "/entities/base/entity"
local LevelView = require "/views/entities/level"

local function Level(world, model)
    local self = Entity(world, model)

    self.complete = model.complete
    self.concept = false
    self.view = LevelView(model.sprite)
    self.nextController = nil

    function self:receive(message, controller)
        if message.name == "finish" then
            self.nextController = self.complete(controller)
        end
    end

    function self:update(dt, controller)
        if self.nextController then
            return self.nextController
        end
        return controller
    end

    return self
end

return Level
