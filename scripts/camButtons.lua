local self = {}
self.camButtons = {
    camback = newImage("assets/images/game/camback.png"),
    cambackon = newImage("assets/images/game/cambackon.png"),
    camsOutline = newImage("assets/images/game/camsoutline.png"),
    map = newImage("assets/images/game/map.png"),

    cam1 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam1.png"),
        selected = false,
    },
    cam2 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam2.png"),
        selected = false,
    },
    cam3 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam3.png"),
        selected = false,
    },
    cam4 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam4.png"),
        selected = false,
    },
    cam5 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam5.png"),
        selected = false,
    },
    cam6 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam6.png"),
        selected = false,
    },
    cam7 = {
        x = 735,
        y = 430,
        img = newImage("assets/images/game/cam7.png"),
        selected = false,
    },
    cam8 = {
        x = 580,
        y = 415,
        img = newImage("assets/images/game/cam8.png"),
        selected = false,
    },
    cam9 = {
        x = 885,
        y = 390,
        img = newImage("assets/images/game/cam9.png"),
        selected = false,
    },
    cam10 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam10.png"),
        selected = false,
    },
    cam11 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam11.png"),
        selected = false,
    },
    cam12 = {
        x = 0,
        y = 0,
        img = newImage("assets/images/game/cam12.png"),
        selected = false,
    },
}
self.assets = Game.assets

function self:draw()
    self.cams = Game.cams
    draw(self.camButtons.map, 550, 375)

    -- now all the seperate buttons :(
        -- draw(self.camButtons.camback, 585, 430)
        --draw(self.camButtons.cam8.img, 590, 435)
    for i, v in pairs(self.camButtons) do
        if type(v) == "table" then
            if self.cams.cur ~= i then
                draw(self.camButtons.camback, v.x, v.y)
            else
                draw(self.camButtons.cambackon, v.x, v.y)
            end
        end
    end
    for i, v in pairs(self.camButtons) do
        if type(v) == "table" then
            draw(v.img, v.x+5, v.y+5)
        end
    end

    local x, _ = Center:toGame(0, 0)
    draw(self.camButtons.camsOutline, x, 0, 0, 1 * Center._SCALE, 1)

    oprint("X: "..love.mouse.getX().." Y: "..love.mouse.getY().."", 0, 0)
    print("X: "..love.mouse.getX().." Y: "..love.mouse.getY().."", 0, 0)
end

function self:mousepressed(x, y, button)
    x, y = Center:toGame(x, y)
    self.cams = Game.cams
    if not self.cams.up then return end
    -- go through all cams, and if its pressed, set the cam to that cam
    for i, v in pairs(self.camButtons) do
        if type(v) == "table" then
            -- check if it was pressed
            if x > v.x and x < v.x + self.camButtons.camback:getWidth() and y > v.y and y < v.y + self.camButtons.camback:getHeight() then
                self.cams.cur = i
                self.assets.static.alpha = 1
                
                self.assets.camblip.curFrame = 1
                self.assets.camblip.paused = false
                self.assets.blip:play()
            end
        end
    end
end

return self