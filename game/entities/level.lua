local Entity = require "/entities/base/entity"

local function Level(world, model)
    local self = Entity(world, model)

    self.complete = model.complete
    self.concept = true

    function self:receive(message, controller)
        if message.name == "finish" then
            self.complete()
        end
    end

    return self
end

return Level
