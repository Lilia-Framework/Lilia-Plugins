﻿local LIA_CVAR_LOWER2 = CreateClientConVar("lia_usealtlower", "0", true)
function MODULE:CalcViewModelView(weapon, _, _, _, _, eyeAngles)
    if not IsValid(weapon) then return end
    local vm_angles = eyeAngles
    local client = LocalPlayer()
    local value = 0
    if not client:isWepRaised() then value = 100 end
    local fraction = (client.liaRaisedFrac or 0) / 100
    local rotation = weapon.LowerAngles or Angle(30, -30, -25)
    if LIA_CVAR_LOWER2:GetBool() and weapon.LowerAngles2 then rotation = weapon.LowerAngles2 end
    vm_angles:RotateAroundAxis(vm_angles:Up(), rotation.p * fraction)
    vm_angles:RotateAroundAxis(vm_angles:Forward(), rotation.y * fraction)
    vm_angles:RotateAroundAxis(vm_angles:Right(), rotation.r * fraction)
    client.liaRaisedFrac = Lerp(FrameTime() * 2, client.liaRaisedFrac or 0, value)
end

function MODULE:SetupQuickMenu(menu)
    menu:addCheck(L("altLower"), function(_, state)
        if state then
            RunConsoleCommand("lia_usealtlower", "1")
        else
            RunConsoleCommand("lia_usealtlower", "0")
        end
    end, LIA_CVAR_LOWER2:GetBool(), "Miscellaneous")
end