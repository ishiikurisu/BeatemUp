return {
    {
        entity = "player",
        x = 150,
        y = 400,
        w = 50,
        h = 50,
        sprite = "Joel",
        health = 200,
        strength = 50,
    },
    {
        entity = "enemy",
        x = 1050,
        y = 400,
        w = 50,
        h = 50,
        color = "green",
        followRange = 500,
        attackRange = 60,
        staminaRange = 2,
        health = 100,
        strength = 50,
    },
    {
        entity = "enemy",
        x = 1750,
        y = 400,
        w = 70,
        h = 70,
        color = "green",
        followRange = 400,
        attackRange = 60,
        staminaRange = 3,
        health = 400,
        strength = 50,
    },
    {
        entity = "brick",
        x = 1050,
        y = 100,
        w = 2100,
        h = 200,
        color = "white"
    },
    {
        entity = "brick",
        x = 25,
        y = 400,
        w = 50,
        h = 400,
        color = "white"
    },
    {
        entity = "brick",
        x = 2075,
        y = 400,
        w = 50,
        h = 400,
        color = "white"
    },
    {
        entity = "brick",
        x = 1050,
        y = 700,
        w = 2100,
        h = 200,
        color = "white"
    },
    {
        entity = "finish_line",
        x = 2000+50-25,
        y = 200+200,
        w = 50,
        h = 400,
        color = "white"
    },
    {
        entity = "level",
        complete = function()
            love.event.quit()
        end
    }
}
