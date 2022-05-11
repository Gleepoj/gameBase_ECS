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

    @u function Entity_PositionToSteeringwheel(en:Entity,sw:SteeringWheel,vc:VelocityComponent,gp:GridPosition,suv:SolverUVComponent){
        sw.previousStream  = sw.solverUVatCoord;
        sw.previousVelocity = sw.velocity;
        sw.solverUVatCoord = suv.uv;
        
        if(!en.exists(TargetGridPosition)){
                      
            sw.location.x = gp.attachX;
            sw.location.y = gp.attachY;

            sw.velocity.x = vc.dx;
            sw.velocity.y = vc.dy;
            
            sw.predicted = VectorUtils.predict(sw.location,sw.velocity);
        }
    }
    @u function computeSteering(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Steer est la force du gouvernaille elle ne represente que la direction 
        //La direction est le resultat de la force interne de la barque(continue), du courant(continue), et du coup de pagaie(ponctuelle)
    }

    @u function computeVelocity(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        //Velocity prend en compte l'inertie, l'acceleration, le freinage et la vitesse maximale
    }

    @u function updatePlayerSteeringForce(sw:SteeringWheel,psc:PaddleSharedComponent,pl:PlayerFlag){
        var d     :Vector = sw.solverUVatCoord;
        var d0    :Vector = sw.previousStream;
        var stream:Vector = new Vector(0,0);
        var speed :Vector = new Vector(0,0);
        var forces:Vector = new Vector(0,0);
        var push  :Vector = new Vector(0,0);
        
        sw.maxForce = 0.06;
        //sw.maxSpeed = 2.4;

        //sw.velocity.x = -M.lerp(sw.previousVelocity.x,psc.leftSX,0.4);
        sw.velocity.x = -M.fclamp(psc.leftSX,-0.2,0.2);
        //sw.velocity.y = -M.lerp(sw.previousVelocity.y,0.8,0.4);
        sw.velocity.y = 0.8;
       
        
        //stream = new Vector(M.lerp(d.x,d0.x,0.9),M.lerp(d.y,d0.y,0.9));
        stream = new Vector(M.fclamp(d.x,d0.x-0.1,d0.x+0.1),M.fclamp(d.y,d0.y-0.1,d0.y+0.1));
        var y = stream.y;
        stream.y = M.fclamp(y,-1,1);
       // stream = new Vector(d.x,d.y);
        speed  = stream.sub(sw.velocity);
        forces = speed.add(push);
        

        sw.steering = forces;
    }

    @u function computeSteeringForce(en:echoes.Entity,sw:SteeringWheel) {
        if(!en.exists(PlayerFlag)){
            var d:Vector = sw.solverUVatCoord;
            sw.steering  = d.sub(sw.velocity);
        } 

        //applyStream(sw);

        sw.eulerSteering = eulerIntegration(sw);
    }
    
    private function applyStream(sw:SteeringWheel){
        var ystream = sw.solverUVatCoord.y;
        if(sw.solverUVatCoord.y > 0)
            ystream *= 0.1;
        
        if(sw.solverUVatCoord.y < 0){
            ystream *= 15;
            sw.maxSpeed = 0.7; 
            sw.maxForce = 0.16;
            //trace(ystream);
        }

        var stream:Vector = new Vector(sw.solverUVatCoord.x*0.7,ystream);
        var steer = sw.steering.clone();
        sw.steering = steer.add(stream);
        
    }

    
    private function eulerIntegration(sw:SteeringWheel){
        // not the exact Reynols integration
        var _temp = sw.steering.clone();
        var _limitTemp = VectorUtils.limitVector(_temp,sw.maxForce);
        var accel = VectorUtils.divideVector(_limitTemp,sw.mass);
        return accel;

    }
  
}