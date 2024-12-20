Person = {}
Person.__index = Person

local pd <const> = playdate
local gfx <const> = pd.graphics

function Person:new(name, health)
    local self = setmetatable({}, Person)
    self.name = name
    self.health = health
end


function cardAttacksPerson(attack)
    Opponent.health =- attack 

    if Opponent.health <= 0 then
        displayMessage("You win!", 15)
    else
        displayMessage("Opponent is at" + Opponent.health, 15)

    end


end