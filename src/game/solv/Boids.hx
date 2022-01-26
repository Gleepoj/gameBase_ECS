package solv;

import hxd.Math;
import h3d.Vector;

 
class Boids extends Entity{
    public static var ALL:Array<Boids> = [];

    public var solver(get,never):Solver; inline function get_solver() return Game.ME.solver;
    public var maxSpeed = 0.1;
    public var maxForce = 1;

    var location:Vector;
    var velocity:Vector;
    var acceleration:Vector;
    var desired:Vector;
    var steer:Vector;
    var angle:Float;
    
    var target:Entity;
    var targetLocation:Vector;
    var targetAngle:Float = 0 ;
    
    var index:Int;
    var autonomy:Bool = true;
    var influenceOnFluid:Bool = false;
    
    var isChasing(get,never):Bool;inline function get_isChasing() { if(target != null) return true; else return false;};
    var isAutonomous(get,never):Bool; inline function get_isAutonomous() return autonomy;
    public var isOnSurface(get,never):Bool; inline function get_isOnSurface()return influenceOnFluid;
    
    public function new(x:Int,y:Int) {
        super(x,y);
        ALL.push(this);

        location     = new Vector(attachX,attachY);
        velocity     = new Vector(dx,dy);
        acceleration = new Vector(0,0);
        desired      = new Vector(0,0);
        steer        = new Vector(0,0);
        targetLocation  = new Vector(attachX+(Math.cos(targetAngle)*30),attachY+(Math.sin(targetAngle)*30));
        

        spr.set(D.tiles.fxCircle15);
        spr.colorize(0x0ea0ff);
        
    }

    override public function fixedUpdate() {
        super.fixedUpdate();
        
        if (!solver.testIfCellIsInGrid(cx,cy))
            destroy();
        
        velocity.x = dx;
        velocity.y = dy;

        location.x = attachX;
        location.y = attachY;
        
        if (target != null){
            targetLocation.x = target.attachX;
            targetLocation.y = target.attachY;
        }
        
        if(isChasing)
            steer = computeTrackingSteering();
        if(!isChasing)
            steer = computeFlowfieldSteering();

        if(isAutonomous)
            dx += steer.x;
            dy += steer.y;
        
    }
    
    public function trackEntity(e:Entity) {
        target = e;  
    }
    
    //desired_velocity = normalize (position - target) * max_speed
    //steering = desired_velocity - velocity
    
    private function computeTrackingSteering() {
        var _temp =  targetLocation.sub(location);//location.sub(targetLocation);
        var l = desired.length();
        desired =  _temp.multiply(0.01);
        
        var steering = desired.sub(velocity);
        //desired.multiply(0.00001);
        return steering;
    }

    private function computeFlowfieldSteering() {


        desired = solver.getUVatCoord(cx,cy); 
        
        var l = desired.length();
        desired.multiply(maxSpeed*l);
        var steering = desired.sub(velocity);
        
        return steering;
    }

}
