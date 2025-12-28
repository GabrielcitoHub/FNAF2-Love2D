local game = {}
local function lerp(a, b, t)
    return a + (b - a) * t
end
function game:fpsLerp(a, b, dt, t)
    return a + (b - a) * (dt / t)
end

function game:enter(night)
    Game = self
    self.ai = require "scripts.ai"

    self.battery = require "scripts.battery"
    self.maxbattery = self.battery
    -- there is 6 battery animations, going from empty, 1 bar, 2 bars, 3 bars, full, and full again
    -- determine the battery needed for the battery animation
    self.batteryAnimationIndexs = {}
    for i = 1, 6 do
        self.batteryAnimationIndexs[i] = math.floor(self.maxbattery / 6 * i)
    end
    -- flip the table

    self.batteryAnimationIndex = 1

    self.am = 0
    self.time = 12

    function timeadvance()
        Timer.after(1, function()
            self.am = self.am + 1
            if self.am >= 70 then
                if self.time == 12 then
                    self.time = 1
                else
                    self.time = self.time + 1
                end
            end
        end)
    end

    self.positions = require "scripts.positions"

    self.office = require "scripts.office"
    self.office.draw = function()
        draw(self.office.normal.img, 0, 0, 0, 1, 1, self.office.normal.x, self.office.normal.y)
        if self.lighton and officeOffset > 200 then
            draw(self.office.leftlight.img, 0, 0, 0, 1, 1, self.office.leftlight.x, self.office.leftlight.y)
        elseif self.lighton and officeOffset < -225 then
            draw(self.office.rightlight.img, 0, 0, 0, 1, 1, self.office.rightlight.x, self.office.rightlight.y)
        elseif self.lighton then
            draw(self.office.middlelight.img, 0, 0, 0, 1, 1, self.office.middlelight.x, self.office.middlelight.y)
        end
    end

    self.assets = require "scripts.assets"

    self.fonts = {
        volter = love.graphics.newFont("assets/fonts/Volter.ttf", 20),
    }
    setFont(self.fonts.volter)

    self.assets.deepbreathing.audio:setLooping(true)

    self.lighton = false

    self.cams = require("scripts.cams")

    self.assets.fansound.audio:setLooping(true)
    self.assets.fansound:play()

    -- set up the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            if v.maxFrames then
                -- if there is a max frame, then only add that many frames
                if v.frameByWidth then
                    for i = 1, v.maxFrames do
                        table.insert(v.frames, newQuad((i - 1) * v.frameWidth, 0, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                else
                    for i = 1, v.maxFrames do
                        table.insert(v.frames, newQuad(0, (i - 1) * v.frameHeight, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                end
            else
                if v.frameByWidth then
                    for i = 1, v.img:getWidth() / v.frameWidth do
                        table.insert(v.frames, newQuad((i - 1) * v.frameWidth, 0, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                else
                    for i = 1, v.img:getHeight() / v.frameHeight do
                        table.insert(v.frames, newQuad(0, (i - 1) * v.frameHeight, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                end
            end

            if v.animFlip then
                v.curFrame = #v.frames
            end
        end
    end

    officeOffset = 0
    self.call = require "scripts.call"
    self.call:play()

    self.maskButton = require "scripts.maskButton"

    self.mapButton = require "scripts.mapButton"
end

function game:update(dt)
    -- update the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet and not v.paused then
            if not v.animFlip then
                v.curFrame = v.curFrame + v.speed * dt
                if v.curFrame >= #v.frames then
                    if not v.pauseOnFinish then
                        v.curFrame = 1
                    else
                        v.curFrame = #v.frames
                        v.paused = true
                    end
                end
            else
                v.curFrame = v.curFrame - v.speed * dt
                if v.curFrame <= 1 then
                    if not v.pauseOnFinish then
                        v.curFrame = #v.frames
                    else
                        v.curFrame = 1
                        v.paused = true
                    end
                end
            end
        end
    end

    self.ai:update(dt)

    if self.lighton then
        self.battery = self.battery - 1
    end

    for i = 1, #self.batteryAnimationIndexs do
        if self.battery <= self.batteryAnimationIndexs[i] then
            self.batteryAnimationIndex = i
            self.batteryAnimationIndexs[i] = -1000
            break
        end
    end
    self.assets.battery.curFrame = self.batteryAnimationIndex
    --oprint(self.batteryAnimationIndex, self.battery, unpack(self.batteryAnimationIndexs))

    local mx, my = Center:toGame(love.mouse.getPosition())
    if mx < 300 then
        officeOffset = officeOffset + 800 * dt
    elseif mx > Center._CANVAS_WIDTH - (300 * Center._SCALE) then
        officeOffset = officeOffset - 800 * dt
    end

    if officeOffset > 300 then
        officeOffset = 300
    elseif officeOffset < -275 then
        officeOffset = -275
    end

    self.maskButton:update(dt)
    
    self.mapButton:update(dt)

    self.lighton = not self.assets.deepbreathing.audio:isPlaying() and love.keyboard.isDown("lctrl")
end

function game:draw()
    push()
    translate(officeOffset, 0)
    self.office:draw()
    draw(self.assets.desk.img, self.assets.desk.frames[math.floor(self.assets.desk.curFrame)], 225, 350, 0, 1, 1)
    draw(self.assets.leftlight.img, -200, 355)
    draw(self.assets.rightlight.img, 1125, 350)
    if self.lighton and officeOffset > 200 then
        draw(self.assets.leftlighton.img, -200, 355)
    elseif self.lighton and officeOffset < -225 then
        draw(self.assets.rightlighton.img, 1125, 350)
    end
    pop()

    if not self.assets.camflip.draw then
        --draw(self.assets.camflip.img, self.assets.camflip.frames[math.floor(self.assets.camflip.curFrame)], 0, 0)
        -- dont draw if paused or curFrame equals frame count

        if self.assets.camflip.curFrame ~= #self.assets.camflip.frames and self.assets.camflip.curFrame ~= 1 then
            draw(self.assets.camflip.img, self.assets.camflip.frames[math.floor(self.assets.camflip.curFrame)], 0, 0)
        end
    end

    if self.assets.deepbreathing.audio:isPlaying() then
        self.assets.mask.y = self:fpsLerp(self.assets.mask.y, self.assets.mask.img:getHeight(), love.timer.getDelta(), 0.05)
    else
        self.assets.mask.y = self:fpsLerp(self.assets.mask.y, 0, love.timer.getDelta(), 0.05)
    end
    self.assets.mask.oy = math.sin(love.timer.getTime()*3) * 10
    local x, _ = Center:toGame(-100, 0)
    draw(self.assets.mask.img, x, self.assets.mask.y-self.assets.mask.img:getHeight()-15, 0, 1 * Center._SCALE, 1, 0, self.assets.mask.oy)
    self.cams:draw()
    draw(self.assets.flashlight.img, 15, 15)
    draw(self.assets.battery.img, self.assets.battery.frames[math.floor(self.assets.battery.curFrame)], 5, 30)

    printf("Night " .. save.night, 800, 20, 100, "right", 0, 2, 2)
    printf(self.time .. " AM", 800, 60, 100, "right", 0, 2, 2)

    self.mapButton:draw()

    self.maskButton:draw()

    --draw(self.assets.danger.img, self.assets.danger.frames[math.floor(self.assets.danger.curFrame)], 0, 0)
end

function game:keypressed(key)
    self.call:keypressed(key)
end

function game:mousepressed(x, y, button)
    self.cams:mousepressed(x, y, button)
end

function game:mousereleased(x, y, button)

end

function game:mousemoved(x, y, dx, dy)

end

return game