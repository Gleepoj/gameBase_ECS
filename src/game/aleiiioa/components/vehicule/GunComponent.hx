package aleiiioa.components.vehicule;


import dn.Cooldown;

class GunComponent {
    public var cd:Cooldown;
    public var fireRate:Float;
    public var fireSpeed:Float;
    public var friendly:Bool = false;
    public var ang:Float;

    public function new(?_friendly:Bool) {
        friendly = _friendly!=null ? _friendly:false;
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
        fireRate = 0.3;
        fireSpeed = 0.5;

        if(friendly)
            ang = -Math.PI/2;
        if(!friendly)
            ang = Math.PI/2;

    }
}