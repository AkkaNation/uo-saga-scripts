while true do
    if(Skills.GetValue('Resisting Spells') >= 80) then
        Player.Say('FlameStrike')
        Pause(1000)
    elseif(Skills.GetValue('Resisting Spells') >= 70) then
        Player.Say('ManaDrain')
        Pause(1000)
    elseif(Skills.GetValue('Resisting Spells') >= 60) then
        Player.Say('Lightning')
    end
    if Player.Hits < Player.HitsMax then
        local bandage = Items.FindByType(0x0E21)
        if bandage then
            Player.UseObject(bandage.Serial)
            Targeting.WaitForTarget(2000)
            Targeting.TargetSelf()
            Pause(10000)
        end
    end
    Pause(100)
end
