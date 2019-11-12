local world_view = require "/views/world_view"
local player_model = require "/entities/player"
local enemy_model = require "/entities/enemy"
local joystick_view = require "/views/joystick"
local broadcaster = require "/signals/broadcaster"
local level_model = require "/models/level"
local brick_model = require "/entities/brick"
local world_controller = { }
world_controller.__index = world_controller

function world_controller:new(world)
    local o = { }
    setmetatable(o, world_controller)
    o.actions = { }

    love.physics.setMeter(2)
    o.world = love.physics.newWorld(0, 0, true)
    o.broadcaster = broadcaster:new()
    o.entities = { }
    local kinds = {
        player = player_model,
        enemy = enemy_model,
        brick = brick_model,
    }

    for _, data in pairs(level_model:load_level(world)) do
        local model = kinds[data.entity]

        if model ~= nil then
            local entity = model:new(o.world, data)
            table.insert(o.entities, entity)
            o.broadcaster:subscribe(entity)
        end
    end

    -- TODO define tangible components
    o.joystick = joystick_view:new(o)
    o.view = world_view:new(o)

    return o
end

function world_controller:push(user_action)
    local action = self.joystick:translate(user_action)
    table.insert(self.actions, action)
end

function world_controller:update(dt)
    local controller = self

    self.world:update(dt)
    for _, action in pairs(self.actions) do
        self.broadcaster:broadcast(action, self)
    end
    self.actions = { }

    for _, it in pairs(self.entities) do
        it:update(dt, self)
    end

    return controller
end

function world_controller:draw()
    self.view:draw(self)
end

return world_controller
