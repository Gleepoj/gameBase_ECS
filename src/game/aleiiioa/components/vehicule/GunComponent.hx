package aleiiioa.components.vehicule;

import hxd.Pixels.Flags;
import dn.Cooldown;

class GunComponent {
    public var cd:Cooldown;
    public var fireRate:Float;

    public function new() {
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
        fireRate = 0.5 ;
    }
}