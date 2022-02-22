package aleiiioa.components;


import dn.Cooldown;
import aleiiioa.systems.collisions.CollisionEvent;
import h3d.Vector;

class CollisionsListener {
    public var bulletHit:Bool = false;
    public var vesselHit:Bool = false;
    public var inpact:Vector  = new Vector(0,0);
    public var cd:Cooldown;
    
    public var lastEvent:CollisionEvent;

    public var onBulletHit(get,never):Bool;
        inline function get_onBulletHit() return cd.has("bullet_inpact") && !cd.has("vessel_inpact");

    public var onVesselHit(get,never):Bool;
        inline function get_onVesselHit() return cd.has("vessel_inpact");

    public function new() {
        lastEvent = new Event_Reset();
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }
}