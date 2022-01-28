package solv;

import hxd.Math;
import h3d.Vector;
import tools.LPoint;


 
class Boids extends Entity{
    public static var ALL:Array<Boids> = [];

    public var solver(get,never):Solver; inline function get_solver() return Game.ME.solver;
    public var maxSpeed = 0.9;
    public var maxForce = 0.4;
    public var mass = 2;// * Math.random(2);//Math.random(3);

    var location:Vector;
    var velocity:Vector;
    var desired:Vector;
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
    var p1:tools.LPoint;
    var p2:tools.LPoint;

    public function new(x:Int,y:Int) {
        super(x,y);
        ALL.push(this);

        location     = new Vector(centerX,centerY);
        velocity     = new Vector(dx,dy);
        desired      = new Vector(0,0);
        steer        = new Vector(0,0);
        targetLocation  = new Vector(0,0);
        
        spr.set(D.tiles.fxCircle15);
        spr.colorize(0x0ea0ff,0.5);
        trashPathInit();
    }



    override public function fixedUpdate() {
        super.fixedUpdate();
        

        if (!solver.testIfCellIsInGrid(cx,cy)){
            destroy();
        }

        updateVectors();
        
        
        if(isChasing)
            steer = seek(targetLocation);
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
        var t = vectorProjection(new Vector(path[1].levelXi,path[1].levelYi),p,new Vector(path[0].levelXi,path[0].levelYi));
        
        var d = p.distance(t);
        
        if (d<20){
            var dest = new Vector(path[0].levelXi,path[0].levelYi);
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

    public function trackEntity(e:Entity) {
        target = e;  
    }

    private function predict(_location:Vector,_velocity:Vector) {
        var predict = _velocity.clone();
        predict.normalize();
        predict.scale(10);
        var p = _location.add(predict);
        return p;
    }
    


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
    
    


    private function trashPathInit() {
        path = [];
       
        p1 = tools.LPoint.fromCaseCenter(20,50);
        p2 = tools.LPoint.fromCaseCenter(20,10);
        
        p1.initSpr();
        p2.initSpr();

        path.push(p1);
        path.push(p2);
    }

}
