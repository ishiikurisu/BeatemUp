local function Entity(world, model)
    local self = { }
    self.concept = true

    function self:receive(message, controller)
    end

    function self:update(dt, controller)
    end

    return self
end

return Entity
