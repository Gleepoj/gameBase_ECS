package solv;

import ldtk.Point;
import hxd.Math;
import h3d.Vector;
import tools.LPoint;


 
class Boids extends Entity{
    public static var ALL:Array<Boids> = [];

    public var solver(get,never):Solver; inline function get_solver() return Game.ME.solver;
    public var maxSpeed = 0.7;
    public var maxForce = 0.5;
    public var mass = 2;// * Math.random(2);//Math.random(3);

    var location:Vector;
    var velocity:Vector;
    var desired:Vector;
    var predicted:Vector;
    var steer:Vector;
    
    var target:Entity;
    var targetLocation:Vector;
    
    var index:Int;
    var autonomy:Bool = true;
    var influenceOnFluid:Bool = false;
    
    var isChasing(get,never):Bool;inline function get_isChasing() { if(target != null) return true; else return false;};
    var isAutonomous(get,never):Bool; inline function get_isAutonomous() return autonomy;
    public var isOnSurface(get,never):Bool; inline function get_isOnSurface()return influenceOnFluid;
    
    public var path:Array<LPoint>;
    //var p1:tools.LPoint;
    //var p2:tools.LPoint;

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
        //po0.initSpr();
        path.push(po0);

        for(p in _path){
            var po = tools.LPoint.fromCaseCenter(p.cx,p.cy);
            //po.initSpr();
            path.push(po);
        }
        endIndex = 1;
        startIndex = 0;
        currentStart = path[startIndex];
        currentEnd = path[endIndex];
        //trace(path.length);
    }

    override public function fixedUpdate() {
        super.fixedUpdate();
        
       // currentStart.spr.colorize(0xff00f0);
       // currentEnd.spr.colorize(0x000f0f);
        if (!solver.testIfCellIsInGrid(cx,cy)){
            destroy();
        }

        updateVectors();
        updatePathPosition();

        if(isChasing)
            steer = followPath();// seek(targetLocation);
        if(!isChasing)
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
    
    private function updatePathPosition() {
        if(checkIfBoidHadReachEnd())
            incrementCurrentPoints();
    }

    private function incrementCurrentPoints() {
        //trace("ok incre");
        //currentStart = path[startIndex];


        if (endIndex < path.length-1){
            startIndex += 1;
            endIndex += 1;
            currentStart = path[startIndex];
            currentEnd = path[endIndex];
        }

    }

    private function checkIfBoidHadReachEnd(){
        var end = new Vector(currentStart.levelXi,currentStart.levelYi);
        var pre = LPoint.fromPixels(location.x,location.y);
        var distance = pre.distCase(currentEnd);
        //trace(distance);
        if(distance < 10 )
            return true;
        return false;
    }

    private function followPath() {
        var p = predict(location,velocity);
        var t = VectorUtils.vectorProjection(new Vector(currentStart.levelXi,currentStart.levelYi),
                                            p,
                                            new Vector(currentEnd.levelXi,currentEnd.levelYi));
        /* var t = vectorProjection(new Vector(currentStart.levelXi,currentStart.levelYi),
                                 p,
                                 new Vector(currentEnd.levelXi,currentEnd.levelYi));
         */
        var d = p.distance(t);
        
        if (d<5){
            var dest = new Vector(currentEnd.levelXi,currentEnd.levelYi);
            return seek(dest);
        }
        return seek(t);

    }

    

    private function eulerIntegration(steering:Vector){
        var _temp = steering.clone();//.limit(maxForce);
        var _limitTemp = _temp.limit(maxForce);
        var accel = _limitTemp.divide(mass);
        accel.add(velocity);
        accel.limit(maxSpeed);
        return accel;
    }

    public function trackEntity(?e:Entity) {
        target = e;  
    }

    private function predict(_location:Vector,_velocity:Vector) {
        var predict = _velocity.clone();
        predict.normalize();
        predict.scale(10);
        var p = _location.add(predict);
        return p;
    }
    

    //deprecated
    private  function vectorProjection(_aLocation:Vector,_predictLocation:Vector,_bLocation:Vector){
        
        var u = _bLocation.sub(_aLocation);
        var uBis = _bLocation.sub(_aLocation);
        var v = _predictLocation.sub(_aLocation);
        
        var sp = scalarProjection(u,v);
        
        uBis.normalize();
        var p = uBis.multiply(sp);
        var f = uBis.multiply(Math.abs(0.3*sp));
        var n = p.add(f);
        return _aLocation.add(n);
    }

    private function scalarProjection(_u:Vector,v:Vector){
        var u = _u.normalized();
        return v.dot(u);
    }
    
    



}
