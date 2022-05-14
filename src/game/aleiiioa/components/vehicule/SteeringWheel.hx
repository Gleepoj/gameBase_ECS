package aleiiioa.components.vehicule;

import h3d.Vector;

class SteeringWheel {
    
    public var maxSpeed = 0.8;//0.8
    public var maxForce = 0.5;//0.05
    
    public var mass = 1.6;// * Math.random(2);//Math.random(3);
    public var windSensitivity:Float = 12;
    public var yAperture:Float = 1;

    public var origin   :Vector;
    public var location :Vector;
    public var velocity :Vector;
    public var desired  :Vector;
    public var acceleration:Vector;
    public var predicted:Vector;
    public var orientation:Vector;

    public var steering :Vector;
    public var eulerSteering:Vector;

    public var target:Vector;
    public var targetDistance:Float;
    public var solverUVatCoord:Vector;
    public var previousStream:Vector;
    public var previousVelocity:Vector;

    public var speed (get,never):Float; inline function get_speed() return velocity.length();
    public var originOrientation(get,never):Float; inline function get_originOrientation() return origin.getPolar();
    public var velocityOrientation(get,never):Float; inline function get_velocityOrientation() return velocity.getPolar();
    public var desiredOrientation (get,never):Float; inline function get_desiredOrientation()  return desired.getPolar();
    public var steeringOrientation(get,never):Float; inline function get_steeringOrientation() return steering.getPolar();
    public var vehiculeOrientation(get,never):Float; inline function get_vehiculeOrientation() return orientation.getPolar();

    public function new() {
        
        origin       = new Vector(0,-1,0,0);
        location     = new Vector(0,0,0,0);
        velocity     = new Vector(0,0,0,0);
        acceleration = new Vector(0,0,0,0);
        desired      = new Vector(0,0,0,0);
        predicted    = new Vector(0,0,0,0);
        orientation  = new Vector(0,0,0,0);

        steering      = new Vector(0,0,0,0);
        eulerSteering = new Vector(0,0,0,0);

        solverUVatCoord = new Vector(0,0,0,0);
        previousStream  = new Vector(0,0,0,0);
        previousVelocity= new Vector(0,0,0,0);
        target  = new Vector(0,0,0,0);
    }
}