--Core libs
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/sprites"

-- class
import "wolf"
import "rabbit"
import "opponent"
import "screenShake"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Game variables
blood = 0  -- Pool of sacrifices for playing cards
playerHand = {nil, nil, nil}  -- three slots, hand cards
playBoard = {nil, nil, nil}  -- Three slots for playing cards
selectedCard = nil  -- Placeholder for selected cards
slot = 1  -- Currently selected slot to play or sacrifice cards
local gameState = "start"  -- game state
screenShakeSprite = ScreenShake()
local textDisplayFrames = 0

Z_INDEXES = {
    Card = 100
}

-- ScreenShake
function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

-- Displaying message for an amount of time
function displayMessage(text, frames)
    messageText = text
    textDisplayFrames = frames
end

-- Gives the player 3 random cards to start
local function randomCard()
    for i = 1, 3 do
        if math.random() <= 0.35 then
            playerHand[i] = WolfCard:new()
        else
            playerHand[i] = RabbitCard:new()
        end
    end
    gameState = "phase1"
end

-- Function to display cards on the board
local function displayBoard()
    gfx.drawText("Blood: " .. blood, 20, 20)
    gfx.drawText("Slot: " .. slot, 20, 40)

    for i = 1, 3 do
        if playerHand[i] then
            gfx.drawText(playerHand[i]:describe(), 20 + (i * 90), 190)  -- Display cards in hand

            -- Draw the card sprite
            --playerHand[i].sprite:moveTo(20, 120 + (i * 30))  -- Adjust the position as needed
            --playerHand[i].sprite:add()
        end
        if playBoard[i] ~= nil then
            gfx.drawText(playBoard[i]:describe(), 20 + (i * 90), 140)  -- Display played card

            -- Draw the played card sprite
            --playerBoard[i].sprite:moveTo(60 + (i * 80), 180)  -- Adjust the position as needed
            --playerBoard[i].sprite:add()
        else
        gfx.drawText("Empty", 20 + (i * 90), 140)  -- Display "Empty" slot
        end
    end

end


-- Update game
function pd.update()
    gfx.clear()  -- Clears the screen
    gfx.sprite.update()

    if gameState == "start" then  -- Start the game
        randomCard()
    end

    -- Display the player's and opponent's board
    displayBoard()
    displayOpponent()

        -- Display the message if the frame counter is greater than 0
    if textDisplayFrames > 0 then
        gfx.drawText(messageText, 100, 100) -- Adjust position as necessary
        textDisplayFrames = textDisplayFrames - 1 -- Decrement the frame counter
    end

    --PLAYER buttons
    buttons()
end
