--========= Magery & Resist Trainer ========--
-- Author: aKKa
-- Server: UO Sagas
-- Description: Trains Magery by casting spells on target. Also trains resisting spells.
--              Automatically meditates for mana and heals when low on health.
--==========================================--

local targetMobile = Mobiles.FindBySerial(1158330)

local meditationMessages = {
    { value = 'You cannot focus your concentration', pause = 10000 },
    { value = 'You must wait a few moments to use another skill', pause = 1000 },
    { value = 'You stop meditation', pause = 100 },
    { value = 'You are at peace', pause = 100 }
}

-- Manages the meditation process to restore mana to full.
-- It handles various system messages until mana is at maximum.
function Meditate()
    while Player.Mana < Player.MaxMana do
        Journal.Clear()
        Skills.Use('Meditation')
        Pause(10000)
        for _, message in ipairs(meditationMessages) do
            if Journal.Contains(message.value) then
                if message.value == 'You are at peace' then
                    return
                else
                    Pause(message.pause)
                    Skills.Use('Meditation')
                end
            end
        end
    end
end

function GetHealingSpellString()
    if targetMobile.DiffHits >= 30 then
        return 'GreaterHeal'
    else
        return 'Heal'
    end
end

-- Restores the targets health to maximum.
-- It will meditate if mana is low, then cast the appropriate healing spell on the target.
function HealTarget()
    if(Player.Mana <= 20) then 
        Meditate()
    end
    Spells.Cast(GetHealingSpellString())
    if Targeting.WaitForTarget(5000) then
        Targeting.Target(targetMobile.Serial)
        Pause(800)
    end
end

-- Main training loop.
while true do
    Pause(50)
    if Player.Mana <= 40 or Journal.Contains('insufficient mana') then
        Meditate()
    end

    if targetMobile.DiffHits >= 30 then
        HealTarget()
    else
        Spells.Cast('Lightning')
        Pause(1000)
        if Targeting.WaitForTarget(5000) then
            Targeting.Target(targetMobile.Serial)
            Pause(800)
        end
    end
end