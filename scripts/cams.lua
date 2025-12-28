local self = {}

local function campanFunc()
    Timer.tween(3, self, {campan = -300}, "linear", function()
        Timer.after(5, function()
            Timer.tween(3, self, {campan = 0}, "linear", function()
                Timer.after(5, campanFunc)
            end)
        end)
    end)
end
self.campan = 0

campanFunc()
self.cams = {
    cam1 = {

    },
    cam2 = {

    },
    cam3 = {

    },
    cam4 = {

    },
    cam5 = {

    },
    cam6 = {

    },
    cam7 = {
        normal = newImage("assets/images/game/mainhall.png"),
        light = newImage("assets/images/game/mainhall-light.png"),
        tc = newImage("assets/images/game/mainhall-tc.png"),
        tclight = newImage("assets/images/game/mainhall-tc-light.png"),
        wblight = newImage("assets/images/game/mainhall-wb-light.png"),
        wflight = newImage("assets/images/game/mainhall-wf-light.png"),

        draw = function()
            if self.lighton then
                love.graphics.draw(self.cams[self.cur].light, 0, 0)
            else
                love.graphics.draw(self.cams[self.cur].normal, 0, 0)
            end
        end
    },
    cam8 = {
        normal = newImage("assets/images/game/partsservice.png"),
        light = newImage("assets/images/game/partsservice-light.png"),
        sflight = newImage("assets/images/game/partsservice-sf-light.png"),
        foxylight = newImage("assets/images/game/partsservice-foxy-light.png"),
        wbgonelight = newImage("assets/images/game/partsservice-wb-gone-light.png"),
        wbwcgonelight = newImage("assets/images/game/partsservice-wbwc-gone-light.png"),
        wbwcwfgonelight = newImage("assets/images/game/partsservice-wbwcwf-gone-light.png"),

        draw = function()
            if self.lighton then
                love.graphics.draw(self.cams[self.cur].light, 0, 0)
            else
                love.graphics.draw(self.cams[self.cur].normal, 0, 0)
            end
        end
    },
    cam9 = {
        normal = newImage("assets/images/game/stage.png"),
        light = newImage("assets/images/game/stage-light.png"),
        tbgone = newImage("assets/images/game/stage-tbgone.png"),
        tbtcgone = newImage("assets/images/game/stage-tbtcgone.png"),
        tbtcwfgone = newImage("assets/images/game/stage-tbtctf-gone.png"),

        draw = function()
            if self.lighton then
                love.graphics.draw(self.cams[self.cur].light, 0, 0)
            else
                love.graphics.draw(self.cams[self.cur].normal, 0, 0)
            end
        end
    },
    cam10 = {

    },
    cam11 = {

    },
    cam12 = {

    },
}
self.camButtons = require "scripts.camButtons"
self.cur = "cam9"
self.up = false
self.assets = Game.assets

function self:update(dt)
end

function self:draw()
    if self.up and self.assets.camflip.paused then
        push()
        translate(self.campan, 0)
        local cam = self.cams[self.cur]
        if cam then
            if cam.draw then
                cam:draw()
            else
                love.graphics.setColor(0, 0, 0)
                rectangle("fill", 0, 0, love.graphics:getWidth() + love.graphics:getWidth() / 3, love.graphics:getHeight())
                love.graphics.setColor(1, 1, 1)
                printf("NO CAM ", 0 - love.graphics:getWidth() / 2, 0 + love.graphics:getHeight() / 4, love.graphics:getWidth(), "center", 0, 2, 2)
            end
        end
        pop()
        setColor(1,1,1,self.assets.static.alpha)
        self.assets.static.alpha = Game:fpsLerp(self.assets.static.alpha, 0.45, love.timer.getDelta(), 0.25)
        draw(self.assets.static.img, self.assets.static.frames[math.floor(self.assets.static.curFrame)], 0, 0)
        setColor(1,1,1,1)
        --setBlendMode("alpha")
        if not self.assets.camblip.paused then
            draw(self.assets.camblip.img, self.assets.camblip.frames[math.floor(self.assets.camblip.curFrame)], 0, 0)
        end

        self.camButtons:draw()

    end
end

function self:mousepressed(x, y, button)
    self.camButtons:mousepressed(x, y, button)
end

return self