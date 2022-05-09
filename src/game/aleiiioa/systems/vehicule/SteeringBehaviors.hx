package aleiiioa.systems.vehicule;

import aleiiioa.components.vehicule.PaddleSharedComponent;
import h3d.Vector;

import echoes.View;
import echoes.Entity;
import echoes.System;



import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.SolverUVComponent;
import aleiiioa.components.core.velocity.VelocityComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.flags.vessel.*;




 
class  SteeringBehaviors extends System {
    var PLAYER_VIEW:View<PlayerFlag,SteeringWheel>;
    var player:Entity;
    public function new() {
        
    }

    @u function updateVectorsTarget(sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,tgp:TargetGridPosition){
            sw.location.x = 0;
            sw.location.y = 0;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);

    }

    @u function updateVectors(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,suv:SolverUVComponent){
        sw.solverUVatCoord = suv.uv;
        
        if(!en.exists(TargetGridPosition)){
                      
            sw.location.x = gp.attachX;
            sw.location.y = gp.attachY;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }

    @u function updateTargetFromTargetGridPosition(sw:SteeringWheel,tgp:TargetGridPosition,gp:GridPosition) {
        sw.target = new Vector(tgp.attachX-gp.attachX,tgp.attachY-gp.attachY);
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        if(!en.exists(TargetGridPosition) && !en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering = d.sub(sw.velocity);
        } 

        if(en.exists(TargetGridPosition))
            sw.steering = seek(sw);

        applyStream(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }
    
    private function applyStream(sw:SteeringWheel){
        var ystream = sw.solverUVatCoord.y;
        if(sw.solverUVatCoord.y > 0 )
            ystream *= 0.1;
        
        if(sw.solverUVatCoord.y < 0 ){
            ystream *= 15;
            sw.maxSpeed = 0.7; 
            sw.maxForce = 0.16;
            //trace(ystream);
        }
        var stream:Vector = new Vector(sw.solverUVatCoord.x*0.7,ystream);
        var steer = sw.steering.clone();
        sw.steering = steer.add(stream);
        
    }

    private function seek(sw:SteeringWheel){
        
        sw.maxForce = 0.02;
        sw.maxSpeed = 0.6;
        sw.targetDistance = sw.location.distance(sw.target);
        sw.maxForce = M.pretty(sw.targetDistance/1000,3);
        var slowRadius:Float = 50;
        var slow:Float = 1;

        if(sw.targetDistance < slowRadius){
            slow = sw.targetDistance*0.5 / slowRadius;
        }

        sw.desired = sw.target.sub(sw.location);
        sw.desired.normalize();
        sw.desired.scale(sw.maxSpeed*slow);
        
        var v = sw.velocity.clone();
        var steer = sw.desired.sub(v);
        return steer;
    
    }

    
    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _temp = sw.steering.clone();
        var _limitTemp = VectorUtils.limitVector(_temp,sw.maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,sw.mass);
        return accel;

    }
  
}