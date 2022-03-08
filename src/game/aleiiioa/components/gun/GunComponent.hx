package aleiiioa.components.gun;


import aleiiioa.systems.vehicule.GunCommand;
import dn.Cooldown;

class GunComponent {
    // Fire rate and cd are frame based;
    public var cd:Cooldown;
    public var fireRate:Float;
    public var fireSpeed:Float;
    
    public var friendly:Bool = false;
    public var ang:Float;
    public var bulletRadius:Int = 5;

    var fireOpen:Bool;
    public var onFire(get,never) : Bool; inline function get_onFire() return fireOpen;

    public var currentCommand:GunCommand;

    public function new(?_friendly:Bool) {
        friendly = _friendly!=null ? _friendly:false;
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
        fireRate = 4; 
        fireSpeed = 0.7;

        if(friendly)
            ang = -Math.PI/2;
        if(!friendly)
            ang = Math.PI/2;

    }

	public function setFireOn() {
        fireOpen = true;
    }

	public function setFireOff() {
        fireOpen = false;
    }
}