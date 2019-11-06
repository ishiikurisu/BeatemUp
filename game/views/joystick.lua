local joystick = { }
joystick.__index = joystick

function joystick:new(controller)
    local o = { }
    setmetatable(o, joystick)

    o.player = nil
    for _, entity in pairs(controller.entities) do
        if entity.kind == "player" then
            o.player = entity
        end
    end

    return o
end


function joystick:translate(inlet)
    local outlet = nil

    if inlet.key == 'w' then
        if inlet.edge == 'rise' then
            outlet = {
                name = "move",
                direction = "up"
            }
        else
            outlet = {
                name = "stop",
                direction = "up"
            }
        end
    elseif inlet.key == 'a' then
        if inlet.edge == 'rise' then
            outlet = {
                name = "move",
                direction = "left"
            }
        else
            outlet = {
                name = "stop",
                direction = "left"
            }
        end
    elseif inlet.key == 's' then
        if inlet.edge == 'rise' then
            outlet = {
                name = "move",
                direction = "down"
            }
        else
            outlet = {
                name = "stop",
                direction = "down"
            }
        end
    elseif inlet.key == 'd' then
        if inlet.edge == 'rise' then
            outlet = {
                name = "move",
                direction = "right"
            }
        else
            outlet = {
                name = "stop",
                direction = "right"
            }
        end
    end

    if outlet ~= nil then
        outlet.agent = self.player
    end

    return outlet
end

return joystick
