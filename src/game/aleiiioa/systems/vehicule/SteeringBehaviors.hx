package aleiiioa.systems.vehicule;

import hxd.Math;
import aleiiioa.components.vehicule.WindSensitivitySharedComponent;
import aleiiioa.components.vehicule.VeilComponent;
import echoes.Entity;
import echoes.View;
import echoes.Entity;
import aleiiioa.components.core.position.*;
import aleiiioa.components.vehicule.PathComponent;
import aleiiioa.components.flags.vessel.*;
import h3d.Vector;
import echoes.System;

import aleiiioa.components.core.velocity.VelocityComponent;
import aleiiioa.components.vehicule.SteeringWheel;


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
    @u function updateVectors(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition){
        if(!en.exists(TargetGridPosition)){
            sw.location.x = gp.attachX;
            sw.location.y = gp.attachY;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }
    @u function updatePlayerWindSensitivityShared(sw:SteeringWheel,ws:WindSensitivitySharedComponent){
        sw.windSensitivity = ws.windSensitivity;
        sw.yAperture = ws.wingYaperture;
    }

    @u function updateTargetFromPath(sw:SteeringWheel,pc:PathComponent) {
        sw.target = getTargetFromPath(sw,pc);
    }

    @u function updateTargetFromTargetGridPosition(sw:SteeringWheel,tgp:TargetGridPosition,gp:GridPosition) {
        sw.target = new Vector(tgp.attachX-gp.attachX,tgp.attachY-gp.attachY);
    }
    @u function updatePlayerSteeringForce(sw:SteeringWheel,ws:WindSensitivitySharedComponent,pl:PlayerFlag){
        var d:Vector = sw.solverUVatCoord;
        var e:Vector = new Vector(0,0);
        var finalV:Vector = new Vector(0,0);

        var ySens = sw.yAperture*15;
        
        if (!ws.attackPosition){
            if(ySens > 0 )
                e = new Vector(d.x,d.y * ySens);
            
            if (ySens == 0 )
                e = d.multiply(0.5);

            var s = e.sub(sw.velocity);
            finalV = s.add(new Vector(ws.xInput,ws.yInput));
            sw.maxForce = 0.2;
        }

        if (ws.attackPosition){
            finalV = new Vector(ws.xInput*10,ws.yInput*10);
            sw.maxForce = 0.4;
        }

        sw.steering = finalV;// e.sub(sw.velocity);
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