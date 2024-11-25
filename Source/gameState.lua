local pd <const> = playdate
local gfx <const> = pd.graphics

opponentHealth = 5 
playerHealth = 5

function cardAttackPerson(attackPoints)
    opponentHealth = opponentHealth - attackPoints 
    if opponentHealth <= 0 then
        endGame()
    end
end

function endGame()
    displayMessage("You win!", 15)
end