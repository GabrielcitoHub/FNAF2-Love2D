return {
    desk = {
        img = newImage("assets/images/game/desk.png"),
        spritesheet = true,
        frameByWidth = false,
        frameWidth = 851,
        frameHeight = 435,

        frames = {},
        curFrame = 1,
        speed = 100,
    },
    mapbutton = {
        img = newImage("assets/images/game/mapbutton.png"),
        spritesheet = false,
        x = 505,
        y = getHeight() - 50,
        movedOut = false
    },
    maskbutton = {
        img = newImage("assets/images/game/maskbutton.png"),
        spritesheet = false,
        x = 15,
        y = getHeight() - 50,
        movedOut = false
    },
    flashlight = {
        spritesheet = false,
        img = newImage("assets/images/game/flashlight.png"),
    },
    battery = {
        spritesheet = true,
        img = newImage("assets/images/game/battery.png"),
        frameByWidth = true,
        frameWidth = 100,
        frameHeight = 50,
        
        frames = {},
        curFrame = 1,
        speed = 0,
        maxFrames = 6
    },
    mask = {
        img = newImage("assets/images/game/mask.png"),
        spritesheet = false,
        x = 0,
        y = 0,
        ox = 0,
        oy = 0,
    },
    static = {
        img = newImage("assets/images/menu/static.png"),
        spritesheet = true,
        frameByWidth = false,
        frameWidth = 1024,
        frameHeight = 768,

        frames = {},
        curFrame = 1,
        speed = 99,
        alpha = 0.5
    },
    camblip = {
        img = newImage("assets/images/game/camblip.png"),
        spritesheet = true,
        frameByWidth = false,
        frameWidth = 1024,
        frameHeight = 768,

        frames = {},
        curFrame = 1,
        speed = 50
    },
    camflip = {
        img = newImage("assets/images/game/camflip.png"),
        spritesheet = true,
        frameByWidth = false,
        frameWidth = 1024,
        frameHeight = 768,
        draw = false,

        frames = {},
        curFrame = 1,
        speed = 50,
        paused = true, -- is paused
        pauseOnFinish = true, -- pause when animation is finished
        animFlip = true -- goes backwards instead of forwards
    },
    danger = {
        img = newImage("assets/images/game/danger.png"),
        spritesheet = true,
        frameByWidth = true,
        maxFrames = 2,
        frameWidth = 57,
        frameHeight = 49,

        frames = {},
        curFrame = 1,
        speed = 5,
    },
    musicboxcounter = {
        img = newImage("assets/images/game/musicbox-counter.png"),
        spritesheet = true,
        frameByWidth = true,
        maxFrames = 22,
        frameWidth = 54,
        frameHeight = 54,

        frames = {},
        curFrame = 1,
        speed = 0
    },
    musicbutton = {
        img = newImage("assets/images/game/musicbutton.png"),
        spritesheet = false,
    },
    musicbuttontext = {
        img = newImage("assets/images/game/musicbutton-text.png"),
        spritesheet = false,
    },
    rec = {
        img = newImage("assets/images/game/rec.png"),
        spritesheet = true,
        frameByWidth = true,
        maxFrames = 2,
        frameWidth = 47,
        frameHeight = 47,

        frames = {},
        curFrame = 1,
        speed = 2,
    },
    camblip = {
        img = newImage("assets/images/game/camblip.png"),
        spritesheet = true,
        frameByWidth = false,
        frameWidth = 1024,
        frameHeight = 768,

        frames = {},
        curFrame = 1,
        speed = 25,
        paused = true,
        pauseOnFinish = true
    },

    leftlight = {
        img = newImage("assets/images/game/leftlight.png"),
        spritesheet = false,
        x = 0,
        y = 0,
        ox = 0,
        oy = 0,
    },
    rightlight = {
        img = newImage("assets/images/game/rightlight.png"),
        spritesheet = false,
        x = 0,
        y = 0,
        ox = 0,
        oy = 0,
    },
    leftlighton = {
        img = newImage("assets/images/game/leftlight-on.png"),
        spritesheet = false,
        x = 0,
        y = 0,
        ox = 0,
        oy = 0,
    },
    rightlighton = {
        img = newImage("assets/images/game/rightlight-on.png"),
        spritesheet = false,
        x = 0,
        y = 0,
        ox = 0,
        oy = 0,
    },


    deepbreathing = {
        spritesheet = false, -- is audio
        audio = love.audio.newSource("assets/audio/deepbreaths.wav"),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    },
    maskon = {
        spritesheet = false,
        audio = love.audio.newSource("assets/audio/FENCING_42_GEN-HDF10953.wav"),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    },
    maskoff = {
        spritesheet = false,
        audio = love.audio.newSource("assets/audio/FENCING_43_GEN-HDF10954.wav"),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    },
    fansound = {
        spritesheet = false,
        audio = love.audio.newSource("assets/audio/fansound.wav"),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    },
    blip = {
        spritesheet = false,
        audio = love.audio.newSource("assets/audio/blip3.wav"),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    },

    call = {
        spritesheet = false,
        audio = (
            save.night == 1 and love.audio.newSource("assets/audio/call 1b.wav") or
            save.night == 2 and love.audio.newSource("assets/audio/call 2b.wav") or
            save.night == 3 and love.audio.newSource("assets/audio/call 3b.wav") or
            save.night == 4 and love.audio.newSource("assets/audio/call 4b.wav") or
            save.night == 5 and love.audio.newSource("assets/audio/call 5b.wav") or
            save.night == 6 and love.audio.newSource("assets/audio/call 6b.wav")
        ),
        play = function(self)
            self.audio:play()
        end,
        stop = function(self)
            self.audio:stop()
        end
    }
}