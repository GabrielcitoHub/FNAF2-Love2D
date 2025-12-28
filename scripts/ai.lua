local self = {}
self.timers = require "scripts.timers"

self.ia = {
    -- All fnaf 2 animatronics ai levels
    tfreddy = 0,
    tbonnie = 0,
    tchica = 0,
    
    mangle = 0,
    balloonboy = 0,
    marionette = 0,

    wfreddy = 0,
    wbonnie = 0,
    wchica = 0,
    wfoxy = 0,
    wgfreddy = 0,
}

function self:update(dt)
    for i, v in ipairs(self.ia) do
        -- if ai doesn't equal 0 and timers are nil
        if v ~= 0 and self.timers[i] == nil then
            -- set timers
            self.timers[i] = Timer.after(5, function()
                self.ai[i] = 0
                self.timers[v] = nil

                -- CHECK IF AI SHOULD MOVE!
                local ai = self.ai[i]
                local rnd = love.math.random(1,20)
                if rnd <= ai then
                    -- can move
                    self.positions[i] = self.positions[i] + 1
                end

                self.timers[i] = nil
            end)
        end
    end
end

return self