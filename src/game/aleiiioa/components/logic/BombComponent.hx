package aleiiioa.components.logic;

import dn.Cooldown;

class BombComponent {
    public var cd:Cooldown;
    public function new() {
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }
}