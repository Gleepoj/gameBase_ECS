package aleiiioa.components.core.physics.collision;


import dn.Cooldown;



class CollisionSensor {
 
    public var cd:Cooldown;

    public var on_land:Bool   = false;
    public var on_ground:Bool = false;
    public var on_left:Bool   = false;
    public var on_right:Bool  = false;
    public var on_ceil:Bool   = false;
    public var on_fall:Bool   = false;
    public var on_jump:Bool   = false;
    
    public var recentlyOnGround(get,never):Bool;
        inline function get_recentlyOnGround() return cd.has("onGround");

    public var onGround(get,never):Bool;
        inline function get_onGround() return on_ground;
    
    public var onLanding(get,never):Bool;
        inline function get_onLanding() return on_land;
     
    public var onLeft(get,never):Bool;
        inline function get_onLeft() return on_left;
    
    public var onRight(get,never):Bool;
        inline function get_onRight() return on_right;
    
    public var onCeil(get,never):Bool;
        inline function get_onCeil() return on_ceil;
    
    public var onFall(get,never):Bool;
        inline function get_onFall() return on_fall;
    
    public var onJump(get,never):Bool;
        inline function get_onJump() return on_jump;

    
    public function new(){
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }
}