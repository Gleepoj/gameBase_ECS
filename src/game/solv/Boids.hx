package solv;

import ldtk.Point;
import hxd.Math;
import h3d.Vector;
import tools.LPoint;


 
class Boids extends Entity{
    public static var ALL:Array<Boids> = [];

    public var solver(get,never):Solver; inline function get_solver() return Game.ME.solver;
    public var maxSpeed = 0.8;
    public var maxForce = 0.7;
    public var mass = 2;// * Math.random(2);//Math.random(3);

    var location :Vector;
    var velocity :Vector;
    var desired  :Vector;
    var predicted:Vector;
    var steer    :Vector;
    
    var target:Entity;
    var targetLocation:Vector;
    
    var index:Int;
    var autonomy:Bool = true;
    var influenceOnFluid:Bool = false;
    
    var isChasing(get,never):Bool;inline function get_isChasing() { if(target != null) return true; else return false;};
    var isOnTrack(get,never):Bool;inline function get_isOnTrack() { if(path.length != 0) return true; else return false;};
    var isAutonomous(get,never):Bool; inline function get_isAutonomous() return autonomy;
    public var isOnSurface(get,never):Bool; inline function get_isOnSurface()return influenceOnFluid;
    
    public var path:Array<LPoint>;


    var currentStart:LPoint;
    var currentEnd:LPoint;
    var endIndex:Int;
    var startIndex:Int;

    public function new(x:Int,y:Int) {
        super(x,y);
        ALL.push(this);
        path = [];

        location     = new Vector(centerX,centerY);
        velocity     = new Vector(dx,dy);
        desired      = new Vector(0,0);
        predicted    = new Vector(0,0);
        steer        = new Vector(0,0);
        targetLocation  = new Vector(0,0);
        
        spr.set(D.tiles.fxCircle15);
        spr.colorize(0x0ea0ff,0.5);
        
    }

    public function addPath(_path:Array<Point>) {
        
        var po0 = tools.LPoint.fromCaseCenter(cx,cy);
        path.push(po0);

        for(p in _path){
            var po = tools.LPoint.fromCaseCenter(p.cx,p.cy);
            path.push(po);
        }
        
        startIndex = 0;
        endIndex = 1;
        currentStart = path[startIndex];
        currentEnd   = path[endIndex];
    }

    public function track(?e:Entity,?_path:Array<Point>) {
        if(e != null)
            target = e;  
        if(_path != null)
            addPath(_path);
            //trace('la ca marche ? donc imprime ca $_path');
            
    }

    override public function fixedUpdate() {
        super.fixedUpdate();
        
        if (!solver.testIfCellIsInGrid(cx,cy)){
            destroy();
        }

        updateVectors();
        

        if(isChasing)
            steer = seek(targetLocation);
        if(isOnTrack && !isChasing){
            updatePathPosition();
            steer = followPath();
        }
        if(!isChasing && !isOnTrack)
            steer = followFlowfield();

        
        var  a = eulerIntegration(steer);

        if(isAutonomous)
            dx += a.x;
            dy += a.y;
        
    }

    private function updateVectors(){
        location.x = centerX;
        location.y = centerY;

        velocity.x = dx;
        velocity.y = dy;
        
        predicted = predict(location,velocity);

        if (target != null){
            targetLocation.x = target.centerX;
            targetLocation.y = target.centerY;
        }
    }

    private function seek(_target:Vector){
        desired = _target.sub(location);
        desired.normalize();
        desired.scale(maxSpeed);
        var v = velocity.clone();
        var steer = desired.sub(v);
        return steer;
    }

    
    private function followFlowfield() {

        desired = solver.getUVatCoord(cx,cy); 
        var steer = desired.sub(velocity);
        return steer;
    }

    private function followPath() {
        var p = predict(location,velocity);
        var t = VectorUtils.vectorProjection(currentStart.toVector(),p,currentEnd.toVector());
        var d = p.distance(t);
        
        if (d<5){
            var dest = currentEnd.toVector();
            return seek(dest);
        }
        return seek(t);

    }

    private function predict(_location:Vector,_velocity:Vector) {
        var predict = _velocity.clone();
        predict.normalize();
        predict.scale(10);
        var p = _location.add(predict);
        return p;
    }
    
    
    private function eulerIntegration(steering:Vector){
        // not the exact Reynols integration
        var _temp = steering.clone();
        var _limitTemp = _temp.limit(maxForce);
        var accel = _limitTemp.divide(mass);
        return accel;
    }

    private function updatePathPosition() {
        if(checkIfBoidHadReachEnd())
            incrementCurrentPoints();
    }

    private function incrementCurrentPoints() {

        if (endIndex < path.length-1){
            startIndex += 1;
            endIndex += 1;
            currentStart = path[startIndex];
            currentEnd = path[endIndex];
        }

    }

    private function checkIfBoidHadReachEnd(){
        var ce = currentEnd.toVector();
        var dist = ce.distance(location);

        if(dist < 10 )
            return true;
        return false;
    }
    

}
