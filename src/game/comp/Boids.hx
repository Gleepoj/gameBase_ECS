package comp;

import ldtk.Point;
import h3d.Vector;
import tools.LPoint;


 
class Boids extends Entity{
    public static var ALL:Array<Boids> = [];
    //la dependance au solver pourrait etre diminuer par un observer ? 
    var solver(get,never):Solver; inline function get_solver() return Game.ME.solver;
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
    var isOnPath(get,never):Bool;inline function get_isOnPath() { if(path.length != 0) return true; else return false;};
    var isAutonomous(get,never):Bool; inline function get_isAutonomous() return autonomy;
    public var isOnSurface(get,never):Bool; inline function get_isOnSurface()return influenceOnFluid;
    
    public var path:Array<LPoint>;

    var currentStart:LPoint;
    var currentEnd:LPoint;
    var endIndex:Int;
    var startIndex:Int;

    var parentEntity:Entity;

    public function new(x:Int,y:Int,?entity:Entity) {
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
        
        if(entity != null){
            parentEntity = entity;
            spr.set(D.tiles.fxCircle7);
            spr.colorize(0x0ea0ff,1);
        }
    }

    
    public function track(?e:Entity,?_path:Array<Point>) {
        if(e != null)
            target = e;  
        if(_path != null)
            addPath(_path);
    }

    override public function fixedUpdate() {
        super.fixedUpdate();
        
        if (!solver.testIfCellIsInGrid(cx,cy)){
            destroy();
        }

        updateVectors();
        

        if(isChasing)
            steer = seek(targetLocation);
        if(isOnPath && !isChasing){
            updatePathPosition();
            steer = seek(getTargetFromPath());
        }
        if(!isChasing && !isOnPath)
            steer = getSteerFromFlowfield();

        
        var  a = eulerIntegration(steer);

        if(isAutonomous)
            dx += a.x;
            dy += a.y;
        
    }

    
    private function seek(_target:Vector){
        desired = _target.sub(location);
        desired.normalize();
        desired.scale(maxSpeed);
        var v = velocity.clone();
        var steer = desired.sub(v);
        return steer;
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
        var _limitTemp = VectorUtils.limitVector(_temp,maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,mass);
        return accel;
    }
        
    private function getSteerFromFlowfield() {

        desired = solver.getUVatCoord(cx,cy); 
        var steer = desired.sub(velocity);
        return steer;
    }

    private function getTargetFromPath() {
        var p = predict(location,velocity);
        var targetClosestOnPath = VectorUtils.vectorProjection(currentStart.toVector(),p,currentEnd.toVector());
        var d = p.distance(targetClosestOnPath);
        
        if (d<5){
            var targetCurrentEnd = currentEnd.toVector();
            return targetCurrentEnd;
        }
        return targetClosestOnPath;
    }

    private function updatePathPosition() {
        if(checkIfBoidHadReachEnd())
            setNextSegmentOnPath();
    }



    private function addPath(_path:Array<Point>) {
        
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


    private function setNextSegmentOnPath() {

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
