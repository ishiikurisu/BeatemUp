local function Level(world, model)
    local self = { }

    self.complete = model.complete
    self.concept = true

    function self:receive(message, controller)
        if message.name == "finish" then
            self.complete()
        end
    end

    function self:update(dt, controller)
    end

    return self
end

return Level