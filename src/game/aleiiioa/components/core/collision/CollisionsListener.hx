package aleiiioa.components.core.collision;


import dn.Cooldown;
import aleiiioa.systems.collisions.CollisionEvent;


class CollisionsListener {
    //public var onPnjArea:Bool = false;
    public var cd:Cooldown;
    
    public var lastEvent:CollisionEvent;

    public var onArea(get,never):Bool;
        inline function get_onArea() return cd.has("pnj ready");

    public function new() {
        lastEvent = new Event_Reset();
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }
}