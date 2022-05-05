package aleiiioa.components.vehicule;

import h3d.Vector;

class SteeringWheel {
    
    public var maxSpeed = 0.8;//0.8
    public var maxForce = 0.5;//0.05
    public var mass = 1.2;// * Math.random(2);//Math.random(3);
    public var windSensitivity:Float = 12;
    public var yAperture:Float = 1;

    public var location :Vector;
    public var velocity :Vector;
    public var desired  :Vector;
    public var predicted:Vector;
    
    public var steering :Vector;
    public var eulerSteering:Vector;

    public var target:Vector;
    public var targetDistance:Float;
    public var solverUVatCoord:Vector;
    
    
    public function new() {
        
        location     = new Vector(0,0);
        velocity     = new Vector(0,0);
        desired      = new Vector(0,0);
        predicted    = new Vector(0,0);

        steering      = new Vector(0,0);
        eulerSteering = new Vector(0,0);

        solverUVatCoord = new Vector(0,0);
        target  = new Vector(0,0);
    }
}