package aleiiioa.systems.vehicule;

import aleiiioa.components.vehicule.WingsSharedComponent;
import h3d.Vector;

import echoes.View;
import echoes.Entity;
import echoes.System;



import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.core.velocity.VelocityComponent;
import aleiiioa.components.vehicule.PathComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.flags.vessel.*;




 
class  SteeringBehaviors extends System {
    var PLAYER_VIEW:View<PlayerFlag,SteeringWheel>;
    var player:Entity;
    public function new() {
        
    }
    @a function onVesselAdded(en:Entity,sw:SteeringWheel){
        //targetPlayer(en);
    }

    @u function updateVectorsTarget(sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,tgp:TargetGridPosition){
            sw.location.x = 0;
            sw.location.y = 0;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);

    }
    @u function updateVectors(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,suv:SolverUVComponent){
        if(!en.exists(TargetGridPosition)){
            sw.solverUVatCoord = suv.uv;           
            
            sw.location.x = gp.attachX;
            sw.location.y = gp.attachY;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }

    @u function updateTargetFromPath(sw:SteeringWheel,pc:PathComponent) {
        sw.target = getTargetFromPath(sw,pc);
    }

    @u function updateTargetFromTargetGridPosition(sw:SteeringWheel,tgp:TargetGridPosition,gp:GridPosition) {
        sw.target = new Vector(tgp.attachX-gp.attachX,tgp.attachY-gp.attachY);
    }

    @u function updatePlayerSteeringForce(sw:SteeringWheel,wsc:WingsSharedComponent,pl:PlayerFlag){
        var d:Vector = sw.solverUVatCoord;
        var wind:Vector = new Vector(0,0);
        var speed:Vector = new Vector(0,0);
        var forces:Vector = new Vector(0,0);

        var yAperture = wsc.aperture*5;
        
        if (!wsc.isLocked){
            if(yAperture > 0 ){
                wind = new Vector(d.x,d.y * yAperture);
                speed = wind.sub(sw.velocity);
                forces = speed.add(new Vector(wsc.inputX,0));
            }
            
            if (yAperture == 0 ){
                //wind = d.multiply(0.5);
                wind = new Vector(0,0);
                speed = wind.sub(sw.velocity);
                forces = speed.add(new Vector(wsc.inputX,Const.SCROLLING_MIN_SPEED));
            }
            sw.maxForce = 0.4;
        }

        if (wsc.isLocked){
            forces = new Vector(wsc.inputX*10,wsc.inputY*10);
            sw.maxForce = 0.4;
        }

        sw.steering = forces;
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        if(!en.exists(PathComponent) && !en.exists(TargetGridPosition) && !en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering = d.sub(sw.velocity);
        } 

        applySensitivity(sw);
        if(en.exists(PathComponent))
            sw.steering = seek(sw);
        
        if(en.exists(TargetGridPosition))
            sw.steering = seek(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }

    private function applySensitivity(sw:SteeringWheel) {
        var tar = sw.target.clone();
        var nx = tar.x +(sw.solverUVatCoord.x * sw.windSensitivity);
        var ny = tar.y +(sw.solverUVatCoord.y * sw.windSensitivity);
        sw.target = new Vector(nx,ny);
    }

    private function seek(sw:SteeringWheel){
        sw.desired = sw.target.sub(sw.location);
        sw.desired.normalize();
        sw.desired.scale(sw.maxSpeed);
        var v = sw.velocity.clone();
        var steer = sw.desired.sub(v);
        return steer;
    }

    
    private function getTargetFromPath(sw:SteeringWheel,pc:PathComponent) {
        var targetClosestOnPath = VectorUtils.vectorProjection(pc.currentStart.gpToVector(),sw.predicted,pc.currentEnd.gpToVector());
        var d = sw.predicted.distance(targetClosestOnPath);
        
        if (d<3){
            var targetCurrentEnd = pc.currentEnd.gpToVector();
            return targetCurrentEnd;
        }

        return targetClosestOnPath;
    } 

    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _temp = sw.steering.clone();
        var _limitTemp = VectorUtils.limitVector(_temp,sw.maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,sw.mass);
        return accel;
    }

    private function targetPlayer(en:Entity){
        if(!en.exists(PlayerFlag)){
            if (PLAYER_VIEW.entities.length > 0 ){
                player = PLAYER_VIEW.entities.head.value;
                var tar = player.get(TargetGridPosition);
                en.add(tar);
            }
        }
    }
   
}