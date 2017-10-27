local TrailMixin = {}
function TrailMixin:included( ITEM )
    function ITEM:Think()
        if IsValid(self.trailEnt) then
            self.trailEnt:SetNoDraw(hook.Run("PS2_VisualsShouldShow", self:GetOwner()) == false)
        end
    end
    Pointshop2.AddItemHook( "Think", ITEM )
end
Pointshop2.RegisterItemClassMixin( "base_trail", TrailMixin)
