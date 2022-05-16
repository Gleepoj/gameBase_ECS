package aleiiioa.components.vehicule;

import h3d.Vector;

class VehiculeComponent {
    public var maxSpeed = 0.8;//0.8
    public var maxForce = 0.5;//0.05
    public var friction = 0.99;
    
    public var mass = 1.6;// * Math.random(2);//Math.random(3);

    public var orientation:Vector;
    
    public var location :Vector;
    public var velocity :Vector;
    public var steering :Vector;

    public var desired  :Vector;
    public var stream   :Vector;
   
    public var acceleration:Vector;
    public var euler:Vector;

    
    public var steeringAngle(get,never):Float; inline function get_steeringAngle() return steering.getPolar();
    public var vehiculeAngle(get,never):Float; inline function get_vehiculeAngle() return orientation.getPolar();
    
    public var speed (get,never):Float; inline function get_speed() return velocity.length();
    
    public var origin(get,never):Vector; inline function get_origin() return new Vector(0,-1,0,0);
    public var zero(get,never):Vector; inline function get_zero() return new Vector();

    public var board(get,never):Vector; inline function get_board() return new Vector(Math.cos(vehiculeAngle + Math.PI/2),Math.sin(vehiculeAngle + Math.PI/2));
    public var predicted(get,never):Vector; inline function get_predicted() return VectorUtils.predict(location,velocity);
    
    public function new (){
        
        location     = new Vector(0,0,0,0);

        velocity     = new Vector(0,0,0,0);
        steering     = new Vector(0,0,0,0);
        orientation  = new Vector(0,0,0,0);
        
        acceleration = new Vector(0,0,0,0);
        desired      = new Vector(0,0,0,0);
        stream       = new Vector(0,0,0,0);
       
        euler = new Vector(0,0,0,0);

    }

    public function addForce(f:Vector){
        var a = acceleration.clone();
        acceleration = a.add(f);
    }

    public function addTorque(a:Float){
        var o = steeringAngle;
        steering =  new Vector(Math.cos(o+a)*1,Math.sin(o+a)*1).normalized();
    }

    public function accelerationFriction(){
        var af = new Vector();
        af.lerp(zero,acceleration,friction);
        acceleration = af;
    }    
}