local level_model = { }

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = { }
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function load_tsv(filename)
    local outlet = { }

    local contents, size = love.filesystem.read('string', filename)
    local lines = split(contents, "\n")
    local headers = { }
    for i, line in pairs(lines) do
        local fields = split(line, "\t")
        if i == 1 then
            headers = fields
        else
            local record = { }
            for j, header in pairs(headers) do
                record[header] = fields[j]
            end
            table.insert(outlet, record)
        end
    end

    return outlet
end

function write_tsv(records)
    for _, record in pairs(records) do
        print("---")
        for key, value in pairs(record) do
            print(key .. ": " .. value)
        end
    end
end

function level_model:load_level(world)
    local level_path = "assets/worlds/" .. world .. "/"
    local world_data_path = level_path .. "world.tsv"
    local world = load_tsv(world_data_path)

    write_tsv(world)
    
    return world
end

return level_model
