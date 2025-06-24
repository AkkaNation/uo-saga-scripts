while true do
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
