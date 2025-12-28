local self = {}
self.assets = Game.assets

function self:update(dt)
    self.cams = Game.cams
    local mx, my = love.mouse.getPosition()
    
    -- if mouse hovers over maskbutton
    if not self.cams.up then
        if mx > self.assets.maskbutton.x and mx < self.assets.maskbutton.x + self.assets.maskbutton.img:getWidth() and my > self.assets.maskbutton.y and my < self.assets.maskbutton.y + self.assets.maskbutton.img:getHeight() then
            if not self.assets.maskbutton.movedOut then
                self.assets.maskbutton.movedOut = true
                if self.assets.deepbreathing.audio:isPlaying() then
                    self.assets.maskon:stop()
                    self.assets.maskoff:play()
                    self.assets.deepbreathing:stop()
                else
                    self.assets.maskoff:stop()
                    self.assets.maskon:play()
                    self.assets.deepbreathing:play()
                end
            end
        else
            if self.assets.maskbutton.movedOut then
                self.assets.maskbutton.movedOut = false
            end
        end
    end
end

function self:draw()
    if not self.cams.up then draw(self.assets.maskbutton.img, self.assets.maskbutton.x, self.assets.maskbutton.y) end
end

return self