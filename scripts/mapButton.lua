local self = {}
self.assets = Game.assets

function self:update(dt)
    self.cams = Game.cams
    local mx, my = Center:toGame(love.mouse.getPosition())
    
    -- if mouse hovers over mapbutton
    if not self.assets.deepbreathing.audio:isPlaying() then
        if mx > self.assets.mapbutton.x and mx < self.assets.mapbutton.x + self.assets.mapbutton.img:getWidth() and my > self.assets.mapbutton.y and my < self.assets.mapbutton.y + self.assets.mapbutton.img:getHeight() then
            if not self.assets.mapbutton.movedOut then
                self.assets.mapbutton.movedOut = true
                self.cams.up = not self.cams.up
                self.assets.camflip.paused = false
                if not self.flippedOnce then
                    self.assets.camflip.animFlip = true
                    self.flippedOnce = true
                else
                    self.assets.camflip.animFlip = not self.assets.camflip.animFlip
                end
                if self.cams.up then
                    self.assets.static.alpha = 1
                    self.assets.camblip.paused = false
                    self.assets.camblip.curFrame = 1
                    self.assets.blip:play()
                end
            end
        else
            if self.assets.mapbutton.movedOut then
                self.assets.mapbutton.movedOut = false
            end
        end
    end
end

function self:draw()
    if not self.assets.deepbreathing.audio:isPlaying() then draw(self.assets.mapbutton.img, self.assets.mapbutton.x, self.assets.mapbutton.y) end
end

return self