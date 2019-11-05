local joystick = { }
joystick.__index = joystick

function joystick:new()
    local o = { }
    setmetatable(o, joystick)
    return o
end

function joystick:translate(inlet)
    local outlet

    -- IDEA maybe this doesnt need to be a class
    if inlet.key == 'w' then
        if inlet.edge == 'rise' then
            outlet = {
                action = "start moving up"
            }
        else
            outlet = {
                action = "stop moving up"
            }
        end
    elseif inlet.key == 'a' then
        if inlet.edge == 'rise' then
            outlet = {
                action = "start moving left"
            }
        else
            outlet = {
                action = "stop moving left"
            }
        end
    elseif inlet.key == 's' then
        if inlet.edge == 'rise' then
            outlet = {
                action = "start moving down"
            }
        else
            outlet = {
                action = "stop moving down"
            }
        end
    elseif inlet.key == 'd' then
        if inlet.edge == 'rise' then
            outlet = {
                action = "start moving right"
            }
        else
            outlet = {
                action = "stop moving right"
            }
        end
    end

    return outlet
end

return joystick
