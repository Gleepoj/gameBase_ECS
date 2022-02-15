package aleiiioa.components.vehicule;

import h3d.Vector;

class SteeringWheel {
    var maxSpeed = 0.8;
    var maxForce = 0.05;
    var mass = 0.5;// * Math.random(2);//Math.random(3);

    public var location :Vector;
    var velocity :Vector;
    var desired  :Vector;
    var predicted:Vector;
    var steer    :Vector;
    
    var target:Entity;
    var targetLocation:Vector;
    
    var index:Int;
    var autonomy:Bool = true;
    public var influenceOnFluid:Bool = false;
    public var pathPriority:Bool = false;
    
    var isChasing(get,never):Bool;inline function get_isChasing() { if(target != null && !pathPriority) return true; else return false;};
    //var isOnPath(get,never):Bool;inline function get_isOnPath() { if(path.length != 0) return true; else return false;};
    var isAutonomous(get,never):Bool; inline function get_isAutonomous() return autonomy;
    public var isOnSurface(get,never):Bool; inline function get_isOnSurface()return influenceOnFluid;
    
    public function new() {
        
        location     = new Vector(0,0);
        velocity     = new Vector(0,0);
        desired      = new Vector(0,0);
        predicted    = new Vector(0,0);
        steer        = new Vector(0,0);
        targetLocation  = new Vector(0,0);
    }
}