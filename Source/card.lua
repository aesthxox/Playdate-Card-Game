-- Define the base Card class
Card = {}
Card.__index = Card

local pd <const> = playdate
local gfx <const> = pd.graphics

local cardImages = {
    wolf = gfx.image.new("images/wolf"),
    rabbit = gfx.image.new("images/rabbit"),
}

function Card:new(name, attack, health, cost)
    local self = setmetatable({}, Card)
    self.name = name
    self.attack = attack
    self.health = health
    self.cost = cost

    -- Create a sprite for the card
    local imageName = name:lower()
    self.sprite = gfx.sprite.new(cardImages[imageName]) -- Use the image based on card name
    self.sprite:moveTo(0, 0) -- Set initial position (you can customize this)
    return self
end

-- Method to describe the card
function Card:describe(health)
    return self.name .. " (" .. self.attack .. "/" .. self.health .. ") Cost: " .. self.cost
end
