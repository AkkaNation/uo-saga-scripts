Messages.Overhead("Starting identifying", 89, Player.Serial)

local items = Items.FindByFilter(
    {
        name = "Unidentified",
        hues = {0},
    }
)

local totalItems = 0

for _, item in ipairs(items) do
    -- Messages.Overhead(i, Player.Serial)
    if item.RootContainer ~= Player.Serial then
        goto continue
    end
    if item.Name ~= nil then
        totalItems = totalItems + 1
    end
    while item.Name ~= nil and string.find(item.Name, "Unidentified") do
        Messages.Overhead(item.Name, Player.Serial)
        Skills.Use('Item Identification')
        Targeting.WaitForTarget(500)
        Targeting.Target(item.Serial)
        Pause(1000)
        if Journal.Contains("Target cannot be seen.") then
            totalItems = totalItems - 1
            Journal.Clear()
            break
        end
    end
    :: continue ::
end

Messages.Overhead(string.format("Done identifying %d items", totalItems), 64, Player.Serial)