local self = {}
self.assets = Game.assets

function self:play()
    self.audio = self.assets.call.audio
    Timer.after(2, function()
        self.audio:play()
    end)
end

function self:keypressed(key)
    if key == "m" and self.audio:isPlaying() then
        self.audio:stop()
    end
end

return self