local world_view = require "/views/world_view"
local player_model = require "/entities/player"
local joystick_model = require "/entities/joystick"
local broadcaster = require "/signals/broadcaster"
local world_controller = { }
world_controller.__index = world_controller

function world_controller:new(world)
    local o = { }
    setmetatable(o, world_controller)
    o.actions = { }

    -- TODO define tangible components
    o.joystick = joystick_model:new()
    o.view = world_view:new(self)

    -- TODO define world, as it should contain entities, geometry, and whatever else is needed to run the game
    o.broadcaster = broadcaster:new()
    o.player = player_model:new()
    o.entities = {
        o.player
    }
    for _, it in pairs(o.entities) do
        o.broadcaster:subscribe(it)
    end

    return o
end

function world_controller:push(user_action)
    local action = self.joystick:translate(user_action)
    table.insert(self.actions, action)
end

function world_controller:update(dt)
    local controller = self

    for _, action in pairs(self.actions) do
        -- IDEA what about I include a context (aka the own controller) in this action?
        -- IDEA I mean, how can an entity interact with the rest world (broadcast their own messages) without a context?
        self.broadcaster:broadcast(action)
    end
    -- IDEA broadcast a "tick" message so I can combine multiple actions at a time
    self.actions = { }

    for _, it in pairs(self.entities) do
        it:update(dt)
    end

    return controller
end

function world_controller:draw()
    self.view:draw(self)
end

return world_controller
